From: taeung <treeze.taeung@gmail.com>
Subject: compile error : about declaration of =?UTF-8?B?4oCYcHRocmVhZF9hdA==?=
 =?UTF-8?B?dHJfc2V0YWZmaW5pdHlfbnDigJk=?=
Date: Tue, 24 Feb 2015 18:02:51 +0900
Message-ID: <54EC3E3B.2040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42046 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbBXJC7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Feb 2015 04:02:59 -0500
Received: by padhz1 with SMTP id hz1so34541633pad.9
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2015 01:02:59 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Hi, Namhyung

After I pulled new changed source codes from 'perf/core' branch=20
(https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git)
,when I compiled perf I've had a problem with error messages as below.

(I'm using as below
system : Ubuntu 14.04.2 LTS 64-bit
kernel version : 3.13.0-40-generic)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
taeung ~/git/tip/tools/perf
  :> make -j4

=2E..(omitted)

In file included from bench/futex-hash.c:17:0:
bench/futex.h:73:19: error: conflicting types for=20
=E2=80=98pthread_attr_setaffinity_np=E2=80=99
  static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr,
                    ^
In file included from bench/futex.h:72:0,
                  from bench/futex-hash.c:17:
/usr/include/pthread.h:407:12: note: previous declaration of=20
=E2=80=98pthread_attr_setaffinity_np=E2=80=99 was here
  extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
             ^
make[3]: *** [bench/futex-hash.o] Error 1
make[2]: *** [bench] Error 2
make[2]: *** Waiting for unfinished jobs....

=2E..(omitted)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

But I modified 'tools/perf/config/feature-checks/Makefile' as Jirka sai=
d=20
(https://lkml.org/lkml/2015/1/12/216)
so I was able to compile perf.


diff --git a/tools/perf/config/feature-checks/Makefile=20
b/tools/perf/config/feature-checks/Makefile
index b32ff33..42ac05a 100644
--- a/tools/perf/config/feature-checks/Makefile
+++ b/tools/perf/config/feature-checks/Makefile
@@ -49,7 +49,7 @@ test-hello.bin:
         $(BUILD)

  test-pthread-attr-setaffinity-np.bin:
-       $(BUILD) -D_GNU_SOURCE -Werror -lpthread
+       $(BUILD) -Werror -lpthread

  test-stackprotector-all.bin:
         $(BUILD) -Werror -fstack-protector-all


Is this patch right ?


Thanks,
Taeung
