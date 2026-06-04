Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DF22F74A;
	Thu,  4 Jun 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584335; cv=none; b=mtsY1eaWpB4W5y9vvf/wPIftcz4K+OH4Nrqb5WWzrnDCXQaX80e4zt1JtB7iijUsNM6XLDOFpG7dTFdyl9QUklp6/tbAqkR/RKGB7w2qaGtIODXT31q21chtle67umDtbjlAPAluv5x4lejJbJ7ZpBP4WyUEJPeWKHXjzK13W+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584335; c=relaxed/simple;
	bh=UfXo9yk/PUr5f3QnQDn4j2nSETYB/f0n5wBITzwvl+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBcHP0GOG8tjw4V2n1Rl55AbxNOG4sQg2jNvFc+EkLtnQtDSS+Z4+pi7krD1AnXj80GAeJk8qmuk3eOwokJB4i3twyRTrbPcns9/GLhg5RTL/hgzTN1dbmMQy7s42FeMRdbmE3hE97sUnz2HBDRwzUl8p/b/1aErU4eBUwmYmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG6UEPcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG6UEPcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A81F00893;
	Thu,  4 Jun 2026 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584334;
	bh=jNL1yofhcudFw/fYt4KHT5qcpp6OgGsaP0hLGMMt54g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nG6UEPcboKi+aZ1eyolDxZ9SwDM4ezDmJ+3dsF6nWBFmHdSZ/3gUeufVne05hOXeo
	 5UyQrbI4mp+7zSusiMZ0zU1kSpyswi4YZLkUgX3YzTSpQkIXO/fz+NFM+pwr4ohgX9
	 UbklPs+E+DBTFdraRuqE/p6/6HHZkOsYN/OYQO2fGyO44qLwdqz52svw+LeNjYKn3+
	 qyKkq1lzob6EzfQU3LcngUiTEgZcw3lpjYlFsLskQ6fnf2cGRWi9x3bqdKOrbqXzsB
	 L1NDwRBDOAeLErvrVlxvwMEy1NT7qN3G46Ue8A+6fEBVJTlRHjci2BdIxOirWiKJEI
	 wIrJoZvzaptEQ==
Date: Thu, 4 Jun 2026 11:45:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v8 18/18] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
Message-ID: <aiGPimuOAmUe4E0U@x1>
References: <20260602073132.2653307-1-irogers@google.com>
 <20260602174129.3192312-1-irogers@google.com>
 <20260602174129.3192312-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260602174129.3192312-19-irogers@google.com>

On Tue, Jun 02, 2026 at 10:41:29AM -0700, Ian Rogers wrote:
> When test descriptions are extremely long (e.g., the truncated perf.data
> graceful handling test is 103 characters long), they wrap across terminal
> boundaries.
>=20
> Because the ANSI escape code to delete the line (PERF_COLOR_DELETE_LINE)
> only clears a single terminal line, visual wrapping leaves orphan
> wrapped lines on the screen, which results in the test description being
> printed multiple times.
>=20
> Resolve this by checking the terminal width (get_term_dimensions) and
> dynamically truncating the printed test description to fit within the
> available columns, leaving safety space for the prefix index and status
> suffix.
>=20
> JUnit XML output and the failure summary report still print the full,
> untruncated test descriptions.
>=20
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>

I processed the first 17 patches this one has this problem, please take
a look:L

  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/lock_contention.skel.h
  CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
tests/builtin-test.c: In function =E2=80=98print_test_result.isra=E2=80=99:
tests/builtin-test.c:420:40: error: =E2=80=98%-*s=E2=80=99 directive output=
 may be truncated writing between 20 and 65505 bytes into a region of size =
256 [-Werror=3Dformat-truncation=3D]
  420 |                 snprintf(buf, buf_sz, "%-*s", width, desc);
      |                                        ^~~~
In file included from /usr/include/stdio.h:974,
                 from /home/acme/git/perf-tools-next/tools/include/linux/pa=
nic.h:6,
                 from /home/acme/git/perf-tools-next/tools/include/linux/ke=
rnel.h:11,
                 from /home/acme/git/perf-tools-next/tools/include/linux/li=
st.h:7,
                 from /home/acme/git/perf-tools-next/tools/perf/util/config=
=2Eh:6,
                 from tests/builtin-test.c:26:
In function =E2=80=98snprintf=E2=80=99,
    inlined from =E2=80=98format_test_description=E2=80=99 at tests/builtin=
-test.c:420:3,
    inlined from =E2=80=98print_test_result.isra=E2=80=99 at tests/builtin-=
test.c:459:3:
/usr/include/bits/stdio2.h:68:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 21 and 65506 bytes into a destination of size 256
   68 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - =
1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
   69 |                                    __glibc_objsize (__s), __fmt,
      |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   70 |                                    __va_arg_pack ());
      |                                    ~~~~~~~~~~~~~~~~~
tests/builtin-test.c: In function =E2=80=98print_test_result.isra=E2=80=99:
tests/builtin-test.c:420:40: error: =E2=80=98%-*s=E2=80=99 directive output=
 may be truncated writing between 20 and 65507 bytes into a region of size =
256 [-Werror=3Dformat-truncation=3D]
  420 |                 snprintf(buf, buf_sz, "%-*s", width, desc);
      |                                        ^~~~
In function =E2=80=98snprintf=E2=80=99,
    inlined from =E2=80=98format_test_description=E2=80=99 at tests/builtin=
-test.c:420:3,
    inlined from =E2=80=98print_test_result.isra=E2=80=99 at tests/builtin-=
test.c:466:3:
/usr/include/bits/stdio2.h:68:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 21 and 65508 bytes into a destination of size 256
   68 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - =
1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
   69 |                                    __glibc_objsize (__s), __fmt,
      |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   70 |                                    __va_arg_pack ());
      |                                    ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95:=
 /tmp/build/perf-tools-next/tests/builtin-test.o] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158=
: tests] Error 2
make[2]: *** [Makefile.perf:566: /tmp/build/perf-tools-next/perf-test-in.o]=
 Error 2
make[2]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:122: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
=E2=AC=A2 [acme@toolbx perf-tools-next]$
acme@number:~/git/perf-tools-next$

acme@number:~/git/perf-tools-next$ gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/16/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=3Dc,c++=
,fortran,objc,obj-c++,ada,go,d,m2,cobol,algol68,lto --prefix=3D/usr --mandi=
r=3D/usr/share/man --infodir=3D/usr/share/info --with-bugurl=3Dhttps://bugz=
illa.redhat.com/ --enable-shared --enable-threads=3Dposix --enable-checking=
=3Drelease --enable-multilib --with-system-zlib --enable-__cxa_atexit --dis=
able-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-=
id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstd=
cxx-zoneinfo=3D/usr/share/zoneinfo --with-linker-hash-style=3Dgnu --enable-=
plugin --enable-initfini-array --with-isl=3D/builddir/build/BUILD/gcc-16.1.=
1-build/gcc-16.1.1-20260515/obj-x86_64-redhat-linux/isl-install --enable-of=
fload-targets=3Dnvptx-none,amdgcn-amdhsa --enable-offload-defaulted --witho=
ut-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=3Dge=
neric --with-tls=3Dgnu2 --with-arch_32=3Di686 --build=3Dx86_64-redhat-linux=
 --with-build-config=3Dbootstrap-lto --enable-link-serialization=3D1 --disa=
ble-libssp
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 16.1.1 20260515 (Red Hat 16.1.1-2) (GCC)
acme@number:~/git/perf-tools-next$


> ---
>  tools/perf/tests/builtin-test.c | 63 +++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index b64fc2204f22..edb4eaa695f1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -20,6 +20,8 @@
>  #include <sys/wait.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
> +#include <sys/ioctl.h>
> +#include "util/term.h"
>  #include "builtin.h"
>  #include "config.h"
>  #include "hist.h"
> @@ -404,19 +406,66 @@ static char *xml_escape(const char *str)
>  	return res ? res : strdup("");
>  }
> =20
> +static const char *format_test_description(const char *desc, int width, =
int max_desc_width,
> +					  char *buf, size_t buf_sz)
> +{
> +	int len =3D strlen(desc);
> +
> +	if (width > max_desc_width)
> +		width =3D max_desc_width;
> +
> +	if (len > max_desc_width) {
> +		snprintf(buf, buf_sz, "%.*s...", max_desc_width - 3, desc);
> +	} else {
> +		snprintf(buf, buf_sz, "%-*s", width, desc);
> +	}
> +	return buf;
> +}
> +
>  static int print_test_result(struct test_suite *t, int curr_suite, int c=
urr_test_case,
>  			     int result, int width, int running,
>  			     const char *err_output, double elapsed)
>  {
> +	char desc_buf[256];
> +	const char *desc =3D test_description(t, curr_test_case);
> +	struct winsize ws;
> +	int max_desc_area_width;
> +	int target_desc_area_width;
> +	int desc_padding;
> +
> +	get_term_dimensions(&ws);
> +	/*
> +	 * Total terminal columns minus space for status e.g. " Running (12 act=
ive)"
> +	 * which is 20 chars, plus a margin of 3 chars =3D 23 chars.
> +	 */
> +	max_desc_area_width =3D ws.ws_col - 23;
> +	if (max_desc_area_width < 40)
> +		max_desc_area_width =3D 40;
> +
> +	/* Standard test has prefix "%3d: " which is 5 chars */
> +	target_desc_area_width =3D width + 5;
> +	if (target_desc_area_width > max_desc_area_width)
> +		target_desc_area_width =3D max_desc_area_width;
> +
>  	if (test_suite__num_test_cases(t) > 1) {
>  		char prefix[32];
>  		int len =3D snprintf(prefix, sizeof(prefix), "%3d.%1d:",
>  				   curr_suite + 1, curr_test_case + 1);
> -		int subw =3D len >=3D 4 ? width + 4 - len : width;
> =20
> -		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
> -	} else
> -		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_=
test_case));
> +		desc_padding =3D target_desc_area_width - (len + 1);
> +		if (desc_padding < 20)
> +			desc_padding =3D 20;
> +
> +		format_test_description(desc, desc_padding, desc_padding, desc_buf, si=
zeof(desc_buf));
> +		pr_info("%s %s:", prefix, desc_buf);
> +	} else {
> +		desc_padding =3D target_desc_area_width - 5;
> +		if (desc_padding < 20)
> +			desc_padding =3D 20;
> +
> +		format_test_description(desc, desc_padding, desc_padding, desc_buf, si=
zeof(desc_buf));
> +		pr_info("%3d: %s:", curr_suite + 1, desc_buf);
> +	}
> =20
>  	switch (result) {
>  	case TEST_RUNNING:
> @@ -700,7 +749,7 @@ static void finish_test(struct child_test **child_tes=
ts, int running_test, int c
>  	 * sub test names.
>  	 */
>  	if (test_suite__num_test_cases(t) > 1 && curr_test_case =3D=3D 0)
> -		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1)=
);
> +		pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
> =20
>  	/*
>  	 * Busy loop reading from the child's stdout/stderr that are set to be
> @@ -976,7 +1025,7 @@ static int finish_tests_parallel(struct child_test *=
*child_tests, size_t num_tes
>  			if (next_child) {
>  				if (test_suite__num_test_cases(next_child->test) > 1 &&
>  				    last_suite_printed !=3D next_child->suite_num) {
> -					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
> +					pr_info("%3d: %s:\n", next_child->suite_num + 1,
>  						test_description(next_child->test, -1));
>  					last_suite_printed =3D next_child->suite_num;
>  				}
> @@ -1040,7 +1089,7 @@ static int finish_tests_parallel(struct child_test =
**child_tests, size_t num_tes
> =20
>  			if (test_suite__num_test_cases(child->test) > 1 &&
>  			    last_suite_printed !=3D child->suite_num) {
> -				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
> +				pr_info("%3d: %s:\n", child->suite_num + 1,
>  					test_description(child->test, -1));
>  				last_suite_printed =3D child->suite_num;
>  			}
> --=20
> 2.54.0.1013.g208068f2d8-goog
