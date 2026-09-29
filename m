Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA547C0EF
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663871; cv=none; b=bXltyjxgsBuJdfh1gt38Ifkg7jzeM60Hfyfc78TK+UfgdHyq50gR69+te0u6WxOg09+qdi4ckIv4Cs6lO3KfRak3aPh0WOZcEjUh8vcNfEsB7SnVDCN9nrzZPc0RjNiVwPx2PHMiVo9UIQ5FozuMqZeP83gEEvQx0QwcYsvdP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663871; c=relaxed/simple;
	bh=Lsbp06oh+Ci3PV+NCuPnuIKOnT42YEPvCjjyy1qVrdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z9AlsoIy5kPCNOtmA4p0/hX5h4Wfoa9NTNUJxy6wvNo9Pqo3NdnE6Sn8uw1rLPGuJ5G7gv5zRanFTnktavYGpveLzNy2kEy1Eo0BtCzjNWIMhbb4dd7sYcyGvCVDsmXhH3WbyAopJI1yR58zyu20vMg0cXgjZUXQLRuxogWjYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvQaKLT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvQaKLT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F71F000FF;
	Tue, 29 Sep 2026 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663869;
	bh=JWBeGznjS7qp2J4eIZx/GN1s27INxUgqu/MEmSON+30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvQaKLT6gZUuoJwMlMHH7mriOR4pSFtVrEU7iiynCqu/Gi90sjd+vR9BWX8nPtmLh
	 3unytzxQG8JIJv9c63oYHDNNT/VuwW7EyEl9+w7PBkmcdGHFIruBINyXQqy8TFzBlF
	 uldVuVxe/2iG1kalTqnFdTa877BkEyUXdNnnWjVRTxJd/uOHzqLKeLOAr6Wcoq4C+u
	 cNal1mUtY4QNcJAn3A3IYnQUkp+2eukgEIs8lfoVE6O3KDxEhQEcUXj/30PpB30OBt
	 LkPr90L3BkmRZuW7IRUDWn9dAnyq0OXPom8bcqARJRcUs0F5JSKN2hnO8fejCRfIVa
	 4v5I2XYpiPd2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] perf python stat-cpi: Fix live mode signal races
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-4-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:37:48 +0000
Message-Id: <20260929063749.5E6F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: unhandled KeyboardInterrupt in stat-cpi init
--

commit 1a071f63d2155dda63d4eb450e190a0e0b0b2876
Author: Ian Rogers <irogers@google.com>

perf python stat-cpi: Fix live mode signal races and test flakiness

This commit attempts to fix live mode signal races by registering signal
handlers earlier and flushing output to prevent test flakiness. It also
modifies the shell test to run the workload longer and poll for output
before sending SIGINT.

> diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
> index 0b7d76876a6c6..da92cf560067a 100755
> --- a/tools/perf/python/stat-cpi.py
> +++ b/tools/perf/python/stat-cpi.py
[ ... ]
> @@ -173,19 +174,19 @@ class StatCpiAnalyzer:
> =20
>      def run_live(self) -> None:
>          """Read counters live."""
> -        try:
> -            evlist =3D self._open_live_evlist()
> -        except OSError as e:
> -            print(f"Failed to open events: {e}", file=3Dsys.stderr)
> -            sys.exit(1)
> -
>          def handle_signal(_signum: int, _frame: Any) -> None:
>              raise KeyboardInterrupt
> =20
>          signal.signal(signal.SIGINT, signal.default_int_handler)
>          signal.signal(signal.SIGTERM, handle_signal)
> =20
> -        print("Live mode started. Press Ctrl+C to stop.")
> +        try:
> +            evlist =3D self._open_live_evlist()
> +        except OSError as e:
> +            print(f"Failed to open events: {e}", file=3Dsys.stderr)
> +            sys.exit(1)
> +
> +        print("Live mode started. Press Ctrl+C to stop.", flush=3DTrue)
>          try:
>              while True:
>                  time.sleep(self.args.interval)

[Severity: Medium]
Will this crash if a signal is received during _open_live_evlist()?

The signal handlers are registered to raise KeyboardInterrupt before
_open_live_evlist() is called, but the try...except KeyboardInterrupt
block below only wraps the while loop.

If SIGINT or SIGTERM is received during this initialization phase, wouldn't=
 it
result in an unhandled KeyboardInterrupt exception, printing a traceback and
bypassing graceful cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D3
