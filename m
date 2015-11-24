From: Michael Petlan <mpetlan@redhat.com>
Subject: bogus values of variables in userspace probes
Date: Tue, 24 Nov 2015 12:18:22 +0100
Message-ID: <1448363902.24573.18.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/XHherrSv92VihFfvfYn"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbbKXLSZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Nov 2015 06:18:25 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 75E3D14CAA9
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2015 11:18:24 +0000 (UTC)
Received: from dhcp-1-123.brq.redhat.com (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tAOBINin018758
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2015 06:18:23 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


--=-/XHherrSv92VihFfvfYn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi *,

I have been playing with perf-probe tool and I found out that some bogus
values of a function argument are obtained by perf-record.

How to reproduce:

gcc -O0 -g -o dummy dummy.c
perf probe -x ./dummy --add 'isprime a'
perf record -e probe_dummy:isprime ./dummy
perf script

The actual output looks like the following:

dummy 32476 [000] 3534401.838454: probe_dummy:isprime: (400530) a=32767
dummy 32476 [000] 3534401.838504: probe_dummy:isprime: (400530) a=32714
dummy 32476 [000] 3534401.838513: probe_dummy:isprime: (400530) a=3
dummy 32476 [000] 3534401.838519: probe_dummy:isprime: (400530) a=4
dummy 32476 [000] 3534401.838525: probe_dummy:isprime: (400530) a=5
dummy 32476 [000] 3534401.838531: probe_dummy:isprime: (400530) a=6
dummy 32476 [000] 3534401.838537: probe_dummy:isprime: (400530) a=7
dummy 32476 [000] 3534401.838543: probe_dummy:isprime: (400530) a=13
dummy 32476 [000] 3534401.838561: probe_dummy:isprime: (400530) a=17

But if you look into the source, you can see that the function isprime()
is called with the following arguments:

int numbers[] = { 2, 3, 4, 5, 6, 7, 13, 17, 19 };

So the first and last ones are omitted, there are some bogus numbers instead
of them and all that is shifted somehow.

Note that when I probe for %ax register it looks correct.

The version of kernel/perf is 4.3.0. The architecture is x86_64.
Am I missing something or is it a bug?

Thank you!
Michael


--=-/XHherrSv92VihFfvfYn
Content-Disposition: attachment; filename="dummy.c"
Content-Type: text/x-csrc; name="dummy.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KCmludCBpc3ByaW1lKGludCBh
KQp7CglpbnQgaTsKCWlmKGEgPD0gMSkKCQlyZXR1cm4gMDsKCWZvcihpID0gMjsgaSA8PSBhIC8g
MjsgaSsrKQoJCWlmKCEoYSAlIGkpKQoJCQlyZXR1cm4gMDsKCXJldHVybiAxOwp9CgppbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKCWludCBudW1iZXJzW10gPSB7IDIsIDMsIDQsIDUs
IDYsIDcsIDEzLCAxNywgMTkgfTsKCWludCBpOwoKCWZvcihpID0gMDsgaSA8IDk7IGkrKykKCXsK
CQlwcmludGYoIiVpICVzIHByaW1lXG4iLCBudW1iZXJzW2ldLCAoaXNwcmltZShudW1iZXJzW2ld
KSk/ICJpcyIgOiAiaXMgbm90Iik7Cgl9CgoJcmV0dXJuIDA7Cn0K


--=-/XHherrSv92VihFfvfYn--
