From: Adrian Hunter <adrian.hunter@intel.com>
Subject: =?UTF-8?Q?Re:_Linux_4.3-rc1_build_error_with_older_elfutils_=22util?=
 =?UTF-8?Q?/symbol-elf.c:41:5:_error:_no_previous_prototype_for_=e2=80=98elf?=
 =?UTF-8?B?X2dldHBoZHJudW3igJki?=
Date: Thu, 17 Sep 2015 09:28:31 +0300
Message-ID: <55FA5D8F.6000502@intel.com>
References: <CAHTgTXVPtzyRuW5tYGuC4Ssxpzgc8uFvnXirbvtrCXbJ7f9RnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12349 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbbIQGbY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Sep 2015 02:31:24 -0400
In-Reply-To: <CAHTgTXVPtzyRuW5tYGuC4Ssxpzgc8uFvnXirbvtrCXbJ7f9RnA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vinson Lee <vlee@twopensource.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Victor Kamensky <victor.kamensky@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

On 17/09/15 01:10, Vinson Lee wrote:
> With Linux 4.3-rc1 I get a perf build error using toolchains with
> older elfutils.
>=20
> The following build error occurs on both CentOS 5.11 (elfutils 0.137)
> and Ubuntu 10.04.4 (elfutils 0.143).
>=20
>   CC       util/symbol-elf.o
> cc1: warnings being treated as errors
> util/symbol-elf.c:41: error: no previous prototype for =E2=80=98elf_g=
etphdrnum=E2=80=99

commit f785f2357673d520a0b7b468973cdd197f336494
removed the 'static' qualifier, presumably because there
are cases where the prototype is in the header but the function is
not in the library.

AFAICT gcc accepts multiple prototypes so long as they are the same
so just adding the prototype should be ok i.e.

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
index 53bb5f59ec58..d9abb0307cc5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -38,6 +38,7 @@ static inline char *bfd_demangle(void __maybe_unused =
*v,
 #endif
=20
 #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
+int elf_getphdrnum(Elf *elf, size_t *dst);
 int elf_getphdrnum(Elf *elf, size_t *dst)
 {
 	GElf_Ehdr gehdr;
