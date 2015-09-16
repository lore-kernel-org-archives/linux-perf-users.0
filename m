From: Vinson Lee <vlee@twopensource.com>
Subject: =?UTF-8?Q?Linux_4=2E3=2Drc1_build_error_with_older_elfutils_=22util=2F?=
	=?UTF-8?Q?symbol=2Delf=2Ec=3A41=3A5=3A_error=3A_no_previous_prototype_for_=E2=80=98elf=5Fg?=
	=?UTF-8?Q?etphdrnum=E2=80=99=22?=
Date: Wed, 16 Sep 2015 15:10:44 -0700
Message-ID: <CAHTgTXVPtzyRuW5tYGuC4Ssxpzgc8uFvnXirbvtrCXbJ7f9RnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36479 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbIPWKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Sep 2015 18:10:46 -0400
Received: by lanb10 with SMTP id b10so20016lan.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2015 15:10:45 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, Victor Kamensky <victor.kamensky@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Hi.

With Linux 4.3-rc1 I get a perf build error using toolchains with
older elfutils.

The following build error occurs on both CentOS 5.11 (elfutils 0.137)
and Ubuntu 10.04.4 (elfutils 0.143).

  CC       util/symbol-elf.o
cc1: warnings being treated as errors
util/symbol-elf.c:41: error: no previous prototype for =E2=80=98elf_get=
phdrnum=E2=80=99

Cheers,
Vinson
