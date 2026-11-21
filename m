Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795232218;
	b=re6Pn95WyIjVcKnUKNRutelhRgLvznDTqNNNLQNw1FloGMt9LUdXxa1GF5CM/eo6OEy/
	 zi6w1DbWgDZHdVlZfd35e9FH0afpqHS2+XViHFSwzQiy6iau4LlJkOiiYdcz0re2BnqVH
	 H/bRf2JRsafk+/gQWWGIx1hZtqGppkOQUi0waG8eEpVsvn70enNdfxM03VzzK80Gy7y4m
	 w8RAfk0rq5LpK4t89Gt0l4Ps7mXP5CCIHIBZ+mtyEqY+Do5LRxxF7r3Pdefd0MXiA2WZT
	 gi1MuMYpMCQZDqEbIthAnMUePExEQ3UQNqEBL+NSBpwQ/bLwxSWnmAoQtIJ/NnIdpsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795232218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qY6U2co8OtXQ+j4oYwnXYI5uqMp+s8aV605/cOhPcQs=;
	b=csE+SxhNiOX4xs6RORv0fJgE+iLto+r74+FQwHAFqOhk40E41hpH6bN1hN2FARzLTwpw
	 3lWXR2e+5SN8Z8Pr3acwAAvoB3DdmmIzJNnkIhu6smn0D9W4CBchCDxyS1pFixjk7p8IY
	 QLo+iuJpZC3ahixx94AIEVSLHi4Vy0ulr/nhw+hVyI9/gLORFOAh7hygClA3UXnuwrR5v
	 4dyNgTOrQH6jsgRoGZvhfxYyAaIvMMuiAd24/6gr0It9xeRll1S+On/XIpaqTevO5o/1U
	 fxg7zr7N86xxWzt/gjSvExBQxF1ERGA6IMSu77RsYmH3bIFWuiJ5gchVNSdgCWqNIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oE/LC1LP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75951606A686
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oE/LC1LP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA97E1F000C0;
	Sat, 21 Nov 2026 03:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795232218;
	bh=qY6U2co8OtXQ+j4oYwnXYI5uqMp+s8aV605/cOhPcQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oE/LC1LP/02xqAd17PB0gTTKm4EKSPLQBk8QI54uyTpG9qBoq//uAGzk2v2oAnBpj
	 2pltz+DW9M33Fa+SVErpnCuhFRipWfnVFS1yJeDFhHkGFV73XjDqzm7xxWexKDSKdJ
	 ZlbSB2+3/AksGfXce3aVziDUVexMBbiokLNtWZuFlw+D2mPa31w97h0VUearnEJQaC
	 aE9lNFRXzVm3HM367wIdsHf34RHOXKAigj4mZgJbFnN2VNVsOWUaxi5TDmd6JGnDuM
	 R/k9njvaXEA5Jmd91wzMdK71W0J/O4WvC+W0qYk5COrdZ+nq45p8uo/dpecOfeLTK+
	 Ft0XRZBI1Og2w==
Message-ID: <sashiko-outbox-226592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/16] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121032052.1392234-16-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
 <20261121032052.1392234-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:36:57 +0000
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
- [Medium] perf scripts: clang check in coverage.sh runs before
  SKIP_BUILD=3D1 is set
- [Medium] perf scripts: stale dlfilters in existing BUILD_DIR fail
  render_report()
- [Low] perf scripts: unused PERF_SOURCES array in coverage.sh
--

commit 54b8c85c84ec187dba6b344cdcebe3e4a53cc9a6
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds scripts/coverage.sh and the coverage and coverage-prep make
targets to build perf with clang source-based coverage, run the perf test
suite, and report line coverage.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..1d49b09258818
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,434 @@

[ ... ]

> +# perf links objects from these directories, so a change in any of them
> +# makes the build stale.
> +PERF_SOURCES=3D("$PERF_DIR" "$TOOLS_DIR/lib/perf" "$TOOLS_DIR/lib/api"
> +	      "$TOOLS_DIR/lib/subcmd" "$TOOLS_DIR/lib/bpf"
> +	      "$TOOLS_DIR/lib/symbol" "$TOOLS_DIR/include"
> +	      "$TOOLS_DIR/arch")

[Severity: Low]
PERF_SOURCES is declared here, but nothing in the script references it.

[ ... ]

> +	say "Building perf in $BUILD_DIR"
> +	[ "$BUILD_DIR" =3D "$PERF_DIR" ] || make_args+=3D(O=3D"$BUILD_DIR")
> +	if ! make -C "$PERF_DIR" "${make_args[@]+"${make_args[@]}"}" \
> +		CC=3Dclang DEBUG=3D1 \
> +		EXTRA_CFLAGS=3D"-fprofile-instr-generate -fcoverage-mapping -gdwarf-$D=
WARF_VERSION" \
> +		-j"$JOBS" > "$BUILD_LOG" 2>&1; then
> +		tail -20 "$BUILD_LOG" >&2
> +		die "build failed, full log in $BUILD_LOG"
> +	fi
> +	tail -1 "$BUILD_LOG"
> +}

[ ... ]

> +llvm_cov_objects()
> +{
> +	echo "$BUILD_DIR/perf"
> +	local so
> +
> +	# These are dlopened by perf and have to be profiled separately;
> +	# libperf is linked into perf as a static library.
> +	for so in libperf-gtk.so libperf-jvmti.so; do
> +		[ -f "$BUILD_DIR/$so" ] && echo "--object=3D$BUILD_DIR/$so"
> +	done
> +	for so in "$BUILD_DIR"/dlfilters/*.so; do
> +		[ -f "$so" ] && echo "--object=3D$so"
> +	done
> +	for so in "$BUILD_DIR"/python/perf*.so; do
> +		[ -f "$so" ] && echo "--object=3D$so"
> +	done
> +}
> +
> +render_report()
> +{
> +	local objects
> +
> +	mapfile -t objects < <(llvm_cov_objects)
> +	say "Generating report"
> +	"$LLVM_COV" report "${objects[@]}" --instr-profile=3D"$PROFDATA" \
> +		> "$REPORT" || die "llvm-cov report failed"
> +}

[Severity: Medium]
Can stale shared objects in an existing BUILD_DIR cause render_report() to
fail?

Unlike objects built via tools/build/Makefile.build, the dlfilters pattern
rules in tools/perf/Makefile.perf do not track compiler flag changes:

tools/perf/Makefile.perf:
$(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<

.SECONDARY: $(DLFILTERS:.so=3D.o)

$(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
	$(QUIET_LINK)$(CC) $(filter-out -static,$(LDFLAGS)) $(EXTRA_CFLAGS) -share=
d -o $@ $<

When coverage.sh runs in a build directory that already had a standard
non-coverage build (or a prior GTK4=3D1 build leaving libperf-gtk.so behind=
),
build_perf() does not rebuild dlfilters/*.so or libperf-gtk.so.
llvm_cov_objects() then passes those uninstrumented binaries via --object=3D
to llvm-cov report, which exits with a "No coverage data found" error.

[ ... ]

> +if [ "$SKIP_BUILD" =3D 0 ]; then
> +	command -v clang > /dev/null ||
> +		die "clang not found, it is the only compiler with -fcoverage-mapping"
> +fi
> +
> +# Root does not rebuild a prepared build: use the perf already in
> +# BUILD_DIR, or build when there is none.
> +if [ "$ROOT" =3D 1 ] && [ "$PREP" =3D 0 ]; then
> +	if [ -x "$BUILD_DIR/perf" ]; then
> +		SKIP_BUILD=3D1
> +		say "Running as root, using the coverage build in $BUILD_DIR"
> +	else
> +		say "Running as root, building perf in $BUILD_DIR"
> +	fi
> +fi

[Severity: Medium]
Should the clang check run after the root block that sets SKIP_BUILD=3D1?
Because SKIP_BUILD is still 0 when the clang check runs, executing
coverage.sh as root against a prepared build fails whenever clang is not
installed on the test host or not in root's PATH.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121032052.1392=
234-1-acme@kernel.org?part=3D15
