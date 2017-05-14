From: Staffan Friberg <sfriberg@kth.se>
Subject: Jitdump format and jit injection behavior
Date: Sun, 14 May 2017 21:44:32 +0000
Message-ID: <1494798272719.24909@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:52877 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdENVoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 May 2017 17:44:38 -0400
Received: from smtp-4.sys.kth.se (localhost.localdomain [127.0.0.1])
        by smtp-4.sys.kth.se (Postfix) with ESMTP id 8646ECDB
        for <linux-perf-users@vger.kernel.org>; Sun, 14 May 2017 23:44:35 +0200 (CEST)
Received: from smtp-4.sys.kth.se ([127.0.0.1])
        by smtp-4.sys.kth.se (smtp-4.sys.kth.se [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id JnmkwG5qVZdC for <linux-perf-users@vger.kernel.org>;
        Sun, 14 May 2017 23:44:34 +0200 (CEST)
Received: from exdb02.ug.kth.se (unknown [192.168.32.112])
        by smtp-4.sys.kth.se (Postfix) with ESMTPS id 9E07862E
        for <linux-perf-users@vger.kernel.org>; Sun, 14 May 2017 23:44:34 +0200 (CEST)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,=0A=
=0A=
I have been writing a JVMTI agent to support the jitdump format, https://gi=
thub.com/sfriberg/perf-jitdump-agent.=0A=
=0A=
Reading the documentation for the jitdump format[1], it states the followin=
g.=0A=
=0A=
IMPORTANT:=0A=
  The JIT_CODE_DEBUG for a given function must always be generated BEFORE t=
he JIT_CODE_LOAD for the function. This facilitates greatly the parser for =
the jitdump file.=0A=
=0A=
Reading this it seems like as long as the JIT_CODE_DEBUG event is written p=
rior to the code load event the file should be parsed correctly. However re=
ading through the source code for the jit inject command (and jitdump parse=
r) it seems like it expects that the JIT_CODE_DEBUG event is directly befor=
e the associated JIT_CODE_DEBUG, if that is not the case multiple issues ca=
n happen.=0A=
=0A=
1. The JIT_CODE_DEBUG information is applied to the wrong method. It is app=
lied to the next found JIT_CODE_LOAD event without checking for a match.=0A=
2. Memory leak if two JIT_CODE_DEBUG events directly follow each other=0A=
=0A=
Since HotSpot and other JVMs generally support methods to be compiled and o=
ptimized in parallel this is a case that can easily happen unless specifica=
lly ensuring the collocation of the two events stringently. I believe the e=
xample JVMTI agent in the kernel is susceptible to generate the wrong order=
 of events as the order of the event is only guarded by locking the file an=
d as such can write the events interleaved with events from other compilati=
ons.=0A=
=0A=
The risk for a memory leak should probably be fixed no matter what, but it =
would be great to understand if the documentation perhaps should be clarifi=
ed (perhaps "DIRECTLY BEFORE") or if jitdump parser should keep track of ea=
rlier JIT_CODE_DEBUG events and match them correctly.=0A=
=0A=
Or it might just be me reading the code wrong.=0A=
=0A=
Regards,=0A=
Staffan=0A=
=0A=
[1] - linux/tools/perf/Documentation/jitdump-specification.txt =
