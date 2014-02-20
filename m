From: Harald Servat <harald.servat@bsc.es>
Subject: perf pebs sampling through stores + period is wrong?
Date: Thu, 20 Feb 2014 12:40:31 +0100
Message-ID: <5305E9AF.3050906@bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050400090209020204060300"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:59625 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbaBTLkd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 20 Feb 2014 06:40:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id A2DFC92611
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2014 12:40:31 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08631-07 for <linux-perf-users@vger.kernel.org>;
 Thu, 20 Feb 2014 12:40:31 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 01289D5216
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2014 12:40:31 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id s1KBeUNS011403
	for linux-perf-users@vger.kernel.org; Thu, 20 Feb 2014 12:40:30 +0100
Received: from [84.88.50.148] (bsccs203.int.bsc.es [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id C5EF9834AB
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2014 12:40:30 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400090209020204060300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

   I'd let you know that I'm observing that the PEBS sampling through 
PEBS stores seem to behave badly (at least to my understanding) in 
cooperation with -c flag.

   I'm running Linux 3.11.0 on a Intel SandyBridge machine with the 
following info

vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
stepping	: 7

   and for testing purposes I'm using the attached program (which simply 
transfers data from one vector to another one) to depict the problem. 
When I use perf stat to get information of the loads & stores of this 
app I get this output (which I reduced manually)

  $ perf stat -e r81d0 ./a.out  # Intel manual [1] in table 19-17 
indicates that event number d0 + umask 81 refers to all loads
   671.488.050 loads

  $ perf stat -e r82d0 ./a.out # The same as before, but for stores
   356.521.360 stores

   We can see there that the number of stores is half the number of 
loads. However, when I use the perf mem record command for every 10k 
loads I get the following info:

   $ perf mem -t load record -c 10000 ./a.out
   [perf record: Woken up 1 times to write data]
   [perf record: Captured and wrote 0.047 MB perf.data (~2036 samples)]

   but when looking for samples every 10k stores I get

   $ perf mem -t store record -c 10000 ./a.out
   ...
   [perf record: Woken up 4 times to write data]
   [perf record: Captured and wrote 0.921 MB perf.data (~40247 samples)]

   Notice that the number of samples raised by 20x, which to me seems 
very odd because the number of stores was half, so I expected 0.5x here. 
Or am I supposing this the wrong way?

   Just for further testing, if I omit the -c parameter (which I need 
:S), it seems to work better

   $ perf mem -t load record  ./a.out
   [perf record: Woken up 1 times to write data]
   [perf record: Captured and wrote 0.172 MB perf.data (~7508 samples)]

   $ perf mem -t store record  ./a.out
   [perf record: Woken up 1 times to write data]
   [perf record: Captured and wrote 0.151 MB perf.data (~6607 samples)]

Best regards.

[1] 
http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf


WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
--------------050400090209020204060300
Content-Type: text/x-csrc;
 name="memcpy.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="memcpy.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *long_str = "This is a very long string!";
char dest[1024*1024*1024];

int main (int argc, char *argv[])
{
	int i;
	int length = strlen (long_str);

	for (i = 0; i < 1024*1024*1024-length; i += length)
		memcpy (&dest[i], long_str, length);

	printf ("CHECK: %c\n", dest[0*length+0]);
	printf ("CHECK: %c\n", dest[1*length+1]);
	printf ("CHECK: %c\n", dest[2*length+2]);
	printf ("CHECK: %c\n", dest[3*length+3]);

	return 0;
}

--------------050400090209020204060300--
