Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885710;
	b=Zrqv+n3PkAs5qwMeCg+sLOJJB8H5TBnckCAKQXNFEv7Hv9Qcli9iasBtXmmNdEBtjnWs
	 4Zi133qRqHNAfGm5I7r42q+qIIwyDZ8MiSc/u7UVZlIGMH5/KZkDqI9D+nmGBWtVu8FFx
	 9/6IUv/Rvgoxmjs/shVERXW/7No/GhT1em81Ux3S6x0CgRagVTYdGOmDGaSreb5kr5pzo
	 MVl2+9fP0vgHKvGfPIWBK6iP5K9lPqCcDy8EVbr9mXkiOEeuQ148B567onSHpUHEaahbJ
	 XrU3162OiEqQVXTTLpNzdVdnmRXjz6Ym6ApPbqakm8lyHyd/RnPtZ2TZ0hQFeaxR5eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eOc4NMcUOu3fFFrPSh27438lMww93H4RfKB1k2FCvgE=;
	b=E7mrzg3dj2I4AjWUdVNVTI8xLXfNAgVs4r6Ejl8qAroAp6k9sXXlgVelva31aYkDf6ZK
	 ztXkLJ7wWcT4bYBwZr88OcqQdxd2JZeMDVlmDTlgHV0afDwZieNpLT/3Q5IA/FD/X6FQ1
	 pHmOEFVnqNosZkarjQEyrBlPIS+GVuE1mFv84EVIztTcozIcUQSRbAydkS9D1OSD1Kwzm
	 8Vh8ZQRtnr0y3VzP6cYTgNOzQDKqSUOSlvTQv2RxyKq5BdUOfYHyGJsY72/9xiYxxIk06
	 HiRlQVu9OQct6BSZVXmiBPUsrl6BNrUyr1wciNLulVX4uszNLMKIbhh0CO6HP6UO+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atRMyhCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325D606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atRMyhCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69541F000C4;
	Tue, 17 Nov 2026 03:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885709;
	bh=eOc4NMcUOu3fFFrPSh27438lMww93H4RfKB1k2FCvgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atRMyhCrHErvBcEOR2oToyLTyyHcSD1pwIATDXClPa/L+eg0bQVV+BV0YdT3Wh74I
	 GTxqfZHn+61vMmCfPqI73lUeOsxN3LWHpy+xt4PGGxW4yo1PyUxJgzTyqWBOAlRDlo
	 K6dG4mfUaQLUwAUgiaJVWy9Ko9786q3TrWA2gstsfv5RgIbATkLL3aoNKt2OxuYFp0
	 RLtjE5EY9iWWh0zWWBwyr+NAxGnMghp0+pXLGVWuTAIy08GjgTUbA/TlOvFTROT0Ol
	 CxLv7Af+mrSQ7SFdfeotjPFlZDf00X/9w9Qq4lbbgowkPpdEwd0T/dyS5DfPwZSRS0
	 hMfzKSrzj452A==
Message-ID: <sashiko-outbox-218136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-2-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:21:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf scripts: coverage.sh: libperf-jvmti.so linked without
  profile runtime
- [Low] perf scripts: coverage.sh: missing timed out test check in
  run_tests()
- [Low] perf scripts: coverage.sh report path regexes require
  tools/perf/ prefix
--

commit 8d4f44c46af7fe536a6ca79e56ff18db52b58791
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds tools/perf/scripts/coverage.sh and corresponding make
targets to build perf with clang source-based coverage, run the perf test
suite, and generate coverage reports and tables.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..aa2649cf08c4a
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,738 @@

[ ... ]

> +build_perf()
> +{
> +	if [ "$SKIP_BUILD" =3D 1 ]; then
> +		check_coverage_build
> +		return
> +	fi
> +
> +	say "Building perf in $BUILD_DIR"
> +	mkdir -p "$BUILD_DIR"
> +	local debug=3D()
> +	[ "$DEBUG_BUILD" =3D 1 ] && debug=3D(DEBUG=3D1)
> +
> +	if ! make -C "$PERF_DIR" O=3D"$BUILD_DIR" CC=3Dclang \
> +		"${debug[@]+"${debug[@]}"}" \
> +		EXTRA_CFLAGS=3D"-fprofile-instr-generate -fcoverage-mapping -gdwarf-$D=
WARF_VERSION" \
> +		-j"$JOBS" > "$BUILD_LOG" 2>&1; then

[Severity: Medium]
Does passing -fprofile-instr-generate only via EXTRA_CFLAGS leave
__llvm_profile_runtime unresolved in libperf-jvmti.so?

jvmti/jvmti-in.o is compiled with EXTRA_CFLAGS, but Makefile.perf links
libperf-jvmti.so without CFLAGS or EXTRA_CFLAGS:

tools/perf/Makefile.perf:
    $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
    	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $=
@ $<

Without -fprofile-instr-generate in LDFLAGS, clang does not link the
profiling runtime into libperf-jvmti.so.  When test_java_symbol.sh loads
$BUILD_DIR/libperf-jvmti.so into jshell via -J-agentpath, the JVM fails to
load the agent due to the unresolved symbol, failing the test and
producing no coverage for libperf-jvmti.so despite llvm_cov_objects()
passing --object=3D$BUILD_DIR/libperf-jvmti.so to llvm-cov.

[ ... ]

> +	# 'perf test' exits 0 even when tests fail, only the summary tells.
> +	if [ "$test_status" =3D 0 ] && grep -qE '^Failed tests +: +[1-9]' "$TES=
T_LOG"; then
> +		test_status=3D1
> +	fi
> +
> +	grep -E '^(Passed|Skipped|Failed) .*:' "$TEST_LOG" || true

[Severity: Low]
Does run_tests() miss tests that time out?

In tools/perf/tests/builtin-test.c, print_tests_summary() tracks and
prints "Timed out tests   : <N>" separately from "Failed tests      : <N>"
while returning 0.  If a test times out (which is more likely under the
default -O0 -g build) and no other test fails, run_tests() omits the timed
out count from the summary and coverage.sh exits with status 0.

[ ... ]

> +file_cov()
> +{
> +	awk -v f=3D"$2" '
> +		function perf_relpath(p) {
> +			if (p ~ /(^|\/)tools\/perf\//)
> +				sub(/^.*tools\/perf\//, "", p)
> +			return p
> +		}
> +		{
> +			g =3D f
> +			sub(/^.*tools\/perf\//, "", g)
> +			rel =3D perf_relpath($1)
> +			if (rel =3D=3D f || rel =3D=3D g || $1 =3D=3D f) {
> +				print $8, $9, $10, $7
> +				exit
> +			}
> +		}' "$1"
> +}

[ ... ]

> +print_worst_files()
> +{
> +	[ "$TOP" -gt 0 ] || return 0
> +	local rows missed lines cover fn path
> +	rows=3D$(awk -v min=3D"$MIN_LINES" '
> +		$1 ~ /(^|\/)tools\/perf\// && $8 >=3D min && $9 > 0 {
> +			path =3D $1
> +			sub(/^.*tools\/perf\//, "", path)
> +			printf "%s %s %s %s %s\n", $9, $8, $10, $7, path
> +		}' "$REPORT" | sort -k1,1nr -k2,2nr | sed -n "1,${TOP}p")

[ ... ]

> +table_row()
> +{
> +	awk -v f=3D"$2" '
> +		function perf_relpath(p) {
> +			if (p ~ /(^|\/)tools\/perf\//)
> +				sub(/^.*tools\/perf\//, "", p)
> +			return p
> +		}
> +		{
> +			g =3D f
> +			sub(/^.*tools\/perf\//, "", g)
> +			path =3D perf_relpath($1)
> +			if (path =3D=3D f || path =3D=3D g || $1 =3D=3D f) {
> +				printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
> +				       path, $8, $8 - $9, $9, $10, $5, $5 - $6, $7
> +				exit
> +			}
> +		}' "$1"
> +}
> +
> +table_rows()
> +{
> +	if [ ${#FOCUS[@]} -gt 0 ]; then
> +		local file
> +		for file in "${FOCUS[@]}"; do
> +			table_row "$REPORT" "$file"
> +		done | sort -t$'\t' -k5,5gr
> +		return
> +	fi
> +
> +	awk -v min=3D"$MIN_LINES" '
> +		$1 ~ /(^|\/)tools\/perf\// && $8 >=3D min && $9 > 0 {
> +			path =3D $1
> +			sub(/^.*tools\/perf\//, "", path)
> +			printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
> +			       path, $8, $8 - $9, $9, $10, $5, $5 - $6, $7
> +		}' "$REPORT" |
> +		sort -t$'\t' -k4,4nr |
> +		if [ "$TOP" -gt 0 ]; then sed -n "1,${TOP}p"; else cat; fi |
> +		sort -t$'\t' -k5,5gr
> +}

[Severity: Low]
Will these tools/perf/ path checks fail to match report entries when the
build directory is inside tools/ (for example, make -C tools/perf O=3Dbuild
coverage)?

llvm-cov report strips the longest common path prefix shared by all
covered files.  Because all covered files in perf and its internal
libraries live under tools/, a build directory inside tools/ causes
llvm-cov report to strip the <srctree>/tools/ prefix and emit paths
starting with perf/ (such as perf/util/evsel.c) instead of tools/perf/.
As a result, print_worst_files() prints nothing, file_cov() reports
focused files as not covered, and print_table() exits with an error that
there is no coverage data in $REPORT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D1
