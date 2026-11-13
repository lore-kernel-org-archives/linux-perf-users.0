Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583403;
	b=G3JVGG+9+qWeQrjN5/CrLHgnaNoDT1imPDVnYqNN3uBmulFjBl6TWbKWFJCfTTG+QE++
	 urDJMGrhY22FJEiJ30WmoLU/Eat+fzcwvmg0WmTd1+nASbPA6JENL140mhz7pbkJswXDP
	 vW/0u+Cv4QaGlconupwNS0YqNRusv/BUZQrtwTylvbpezoSpe8ZXpgcdGyEFWpx4A0jDy
	 zwfTUFiWKi3LFJuR3zv7fMm86xPWU2KyCWyJR0tjP/Xn5WoeFgUxDlYM156z5hpJx8IPw
	 gh0p2uakEgNdnRD3iR/cc/trmSPoI3YGeKUvLc+hJgg5S/mkd1KGClToJAu1rMAZRDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j9ysHiaiZXzDCT15zovSCKr1wAbYNpFe/2OqBTHN+DA=;
	b=L83mjTZcW9Hf0+W+NsKz/NmudXkrZUhOFhOON2jkLjD2iUOA17XJ03aUELqlQ1i9XmLM
	 s01pyt9PbVGD96yHyg+mB2OWTmf3usMraSgt9+1BjDBjXeSnx6OmWFXliIgicG7QV5RT5
	 WWquIM/eWWVQBb5RL0G4z019NTive5RyZnJf+G1M0EyI559OqP8/R902rwp+Y4MAGPW0G
	 XCSmyuiq9m27uUzv73uSy14st7fVArLFuITBZutJZuoxsvnqTsfhJSooaz1Wr0GN4CHP6
	 hTnUB5Kttc6NZ9K57IF2mfAf0RXo8C1+LdThjTCaO+MzWnkEP2DQtdud2ujaYeubRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDf1leB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF6606A893
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDf1leB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881561F000C6;
	Fri, 13 Nov 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583402;
	bh=j9ysHiaiZXzDCT15zovSCKr1wAbYNpFe/2OqBTHN+DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDf1leB246MkxCOq2UEpSLeMsdE/bY4mcAsIBRqVowRe6ESZzxMuOJaHD9Rw9wjfh
	 XaRD0ncsNt9r9Gta7NdKVIuFmZhb5/0SsdmPIUysFYoWySy0cW5lgWclzZZKCowNBm
	 /LIgbQczbuu7ATLa0IcFP5ciTNOV0zmcbgNFK0egTNnmoVnp6k6cNF45y0ktjSVK6e
	 nA0wopmdDHhN+aN6M4o3FLGjGBO4JluVKl58Xn00vCo5rL5KO2QB7+urT+Qm2qPf8Q
	 QmvXWMUYXzSJxlMIOO48gvFDH7QZuxzer1g1LXQPGpo3GP0TKHkOJ3Jc+l5F7Sc/6Q
	 wP8pfxh5LuMfw==
Message-ID: <sashiko-outbox-213082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/12] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-2-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:23:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Low] perf scripts: llvm_cov_objects() looks for perf.so in wrong
  directory
- [Low] perf scripts: misplaced delta header and bad alignment in
  print_summary()
- [Low] perf scripts: print_uncovered() fails to strip tools/perf/ path
  prefix
- [Low] perf build: inconsistent O=3D handling in Makefile coverage
  targets
- [Low] perf scripts: locale-sensitive float handling in print_table()
- [Low] perf scripts: print_worst_files() checks total lines instead of
  missed
--

commit e4ee2d1add56afe4f156fafd475dce263c39b01d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds tools/perf/scripts/coverage.sh and corresponding make
targets to build perf with clang source-based coverage, run the perf test
suite, and generate line and function coverage reports and ASCII tables.

> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index 00baf90e5bda7..d00b63ca011c2 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -140,6 +140,15 @@ check-headers:
>  sync-headers:
>  	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
> =20
> +coverage-prep:
> +	@./scripts/coverage.sh --prep $(if $(O),--build-dir=3D$(O)) $(COVERAGE_=
ARGS)
> +
> +coverage:
> +	@./scripts/coverage.sh $(COVERAGE_ARGS)
> +
> +coverage-table:
> +	@./scripts/coverage.sh --table $(COVERAGE_ARGS)

[Severity: Low]
Should coverage and coverage-table also pass --build-dir, and should all
three targets use $(FULL_O) instead of $(O)?

Without --build-dir, running make -C tools/perf O=3D/path/to/build coverage
(or coverage-table) ignores O=3D and falls back to the default build
directory.  In addition, passing raw $(O) to coverage.sh resolves relative
paths against tools/perf rather than the caller's working directory,
whereas $(FULL_O) canonicalizes $(O) against $(PWD).

[ ... ]

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..19b0da22000c3
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh

[ ... ]

> +llvm_cov_objects()
> +{
> +	echo "$BUILD_DIR/perf"
> +	local so
> +	for so in perf.so libperf.so libperf-jvmti.so; do
> +		[ -f "$BUILD_DIR/$so" ] && echo "--object=3D$BUILD_DIR/$so"
> +	done
> +}

[Severity: Low]
Does this miss the Python C extension object?  Makefile.perf builds the
extension with PYTHON_EXTENSION_SUFFIX (for example,
perf.cpython-312-x86_64-linux-gnu.so) and copies it into
$(OUTPUT)python/, so $BUILD_DIR/perf.so does not exist and coverage for
util/python.c is omitted from the reports.  Matching
$BUILD_DIR/python/perf*.so would include it.

[ ... ]

> +print_worst_files()
> +{
> +	[ "$TOP" -gt 0 ] || return 0
> +	local rows missed lines cover fn path
> +	rows=3D$(awk -v min=3D"$MIN_LINES" '
> +		$1 ~ /(^|\/)tools\/perf\// && $8 >=3D min && $8 > 0 {
> +			path =3D $1
> +			sub(/^.*tools\/perf\//, "", path)
> +			printf "%s %s %s %s %s\n", $9, $8, $10, $7, path
> +		}' "$REPORT" | sort -k1,1nr -k2,2nr | sed -n "1,${TOP}p")

[Severity: Low]
Should the second awk check be $9 > 0 (missed lines) instead of $8 > 0
(total lines), matching table_rows()?  Checking $8 > 0 is redundant with
$8 >=3D min and allows files with 0 missed lines to be listed under largest
uncovered files.

[ ... ]

> +	if [ "$USE_BASELINE" =3D 1 ] && [ -f "$BASELINE" ]; then
> +		printf "  %-8s %8s  %8s  %9s\n" "File" "Previous" "Current" "Delta"
> +		printf "  %-8s %8s  %8s  %9s\n" "--------" "--------" "--------" "----=
-----"
> +	fi
> +
> +	printf "  \033[1m%-44s\033[0m %8s  %8s  %8s  %8s\n" \
> +		"file" "lines" "cover" "missed" "fn-cover"
> +	for file in "${FOCUS[@]}"; do
> +		cov=3D$(file_cov "$REPORT" "$file")
> +		if [ -z "$cov" ]; then
> +			printf "  %-36s %8s\n" "$file" "not covered"
> +			continue
> +		fi
> +		printf "  %-36s %8s  %6s  %6s  %8s\n" "$file" \
> +			"$(echo "$cov" | awk '{print $1}')" \
> +			"$(echo "$cov" | awk '{print $3}')" \
> +			"$(echo "$cov" | awk '{print $2}')" \
> +			"$(echo "$cov" | awk '{print $4}')"
> +	done
> +
> +	if [ "$USE_BASELINE" =3D 1 ] && [ -f "$BASELINE" ]; then
> +		printf "\n  per file delta since %s\n" "$BASELINE"
> +		for file in "${FOCUS[@]}"; do
> +			report_delta "$BASELINE" "$REPORT" "$file"
> +		done
> +	fi
> +}

[Severity: Low]
Are the baseline delta header and row widths in print_summary()
misaligned when -f is used?

The 4-column "File Previous Current Delta" header is printed right above
the 5-column focus table instead of in the "per file delta since
$BASELINE" block below where report_delta() is called.  In the 5-column
focus table itself, the header uses "%-44s %8s  %8s  %8s  %8s", while the
rows use "%-36s %8s  %6s  %6s  %8s", shifting the numeric columns out of
alignment.

Also, because update_baseline() copies $REPORT to $BASELINE at the end of
a run (moving the prior baseline to $BASELINE.prev), a subsequent
--report-only run compares $REPORT against $BASELINE (itself) and always
reports a +0.00% delta.

[ ... ]

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
> +
> +print_table()
> +{
> +	local rows total path lines hit missed pct funcs funcs_hit func_cov
> +	local row_fmt w d_file d29 d13 d10 d8
> +
> +	rows=3D$(table_rows)

[ ... ]

> +	row_fmt=3D$(printf '=E2=94=82 %%-%ds =E2=94=82 %%6s =E2=94=82 %%6s =E2=
=94=82 %%6s =E2=94=82 %%s %%5.1f%%%%' "$w")
> +	row_fmt+=3D' =E2=94=82 %5s/%-5s =E2=94=82 %8s =E2=94=82\n'
> +
> +	while IFS=3D$'\t' read -r path lines hit missed pct funcs funcs_hit fun=
c_cov; do
> +		printf "$row_fmt" "$path" "$lines" "$hit" "$missed" \
> +			"$(bar "$pct" 20)" "$pct" "$funcs_hit" "$funcs" "$func_cov"
> +	done <<< "$rows"

[Severity: Low]
Does --table fail under locales where LC_NUMERIC uses a comma decimal
separator (for example, de_DE.UTF-8 or pt_BR.UTF-8)?

awk emits dot-separated floats in $pct (such as "33.53"), which sort -g
and bash's built-in printf "%5.1f" then parse according to LC_NUMERIC.
When LC_NUMERIC expects a comma, printf rejects $pct as an invalid number
and exits with status 1, aborting the script under set -e.  Exporting
LC_ALL=3DC or LC_NUMERIC=3DC at the top of the script would avoid this.

[ ... ]

> +print_uncovered()
> +{
> +	[ "$UNCOVERED" -gt 0 ] || return 0
> +	[ ${#FOCUS[@]} -gt 0 ] || return 0
> +	local objects file out lines header=3D0
> +	mapfile -t objects < <(llvm_cov_objects)
> +
> +	for file in "${FOCUS[@]}"; do
> +		# No report row means the file was not built: print_summary()
> +		# already said so, llvm-cov show would dump the whole profile.
> +		[ -n "$(file_cov "$REPORT" "$file")" ] || continue
> +		out=3D$("$LLVM_COV" show "${objects[@]}" --instr-profile=3D"$PROFDATA"=
 \
> +			"$PERF_DIR/$file" 2>/dev/null |

[Severity: Low]
Should print_uncovered() strip a leading .*tools/perf/ prefix from $file
before prepending $PERF_DIR/?

file_cov() and table_row() both strip ^.*tools/perf/ so that paths like
-f tools/perf/util/evsel.c work, but passing "$PERF_DIR/$file" directly to
llvm-cov show produces "$PERF_DIR/tools/perf/util/evsel.c" and fails to
find the source file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D1
