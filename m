Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08733C188
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918027; cv=none; b=a+GEx1qX255hqOYcmcQmU7cI2/ZPbPDhrxPGUM+Zn8NCGd/KG0AQQip7UjxqRZpzuDc0vhqzxhcTYOqnVuLypr43Nzb2ypHZjetHJqaRgRkMkvXQ2EiGNxcgRMO9VSFx4CZI2L1MNQTPLXoHeMHziZ9HLbnjc2/CMbh/K4DRbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918027; c=relaxed/simple;
	bh=99MNnI17M3EeBu7+1zM/cwhnhrnWPPboSGUECFwOd80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7Skjlv9oKR2T7hxKAHLsDGERA7Nz3PvBb4WPIgrwDKvNp2E9zrAEB22tGR/F6uiI1rsgZyDyJ6qM3GJiMg4uj8pE/xDlt+oszsMlNtm0zTGcwr9NsvQzS2qOBgLsyztT/hdUl1DemZp5uvc1u2Z5S6PVujw8JrpsQbHKAzDmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0pcqDPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0pcqDPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322ECC2BCB2;
	Thu, 23 Apr 2026 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918027;
	bh=99MNnI17M3EeBu7+1zM/cwhnhrnWPPboSGUECFwOd80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q0pcqDPEds6HL63b14i4VHj9B2JhERiolaJ6Vgz06INZyRPI1WNm4ryF5GAHn2aJO
	 xZ1R8wwBkUb+ypqzeRY0nTUBtdeouEV7+kTGTSk4qYraYn2Vz2EO7WhAj+rbu3C+Nu
	 W9nDpEUCL2gNtI/k5YIhkAvV2OOM57zv/vQgGX6yVCYEkCIGMNLSVru3rkhtbtuTmP
	 AGbpIydNarmkOQ/hKjj0GqZDivQnBdUY+yTbl/DiE8UbjsrCXljED6xjEbISWiN/BT
	 hV/2QzAT15yox1aBqk7ms/KsdPZntLBFALmn1BGJmtLmTTsPow1SPUXmYYNUtYwx4x
	 IVjDelxt1OeVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/58] perf gecko: Port gecko to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-32-irogers@google.com>
References: <20260423035526.1537178-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:20:26 +0000
Message-Id: <20260423042027.322ECC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The local HTTP server exposes the entire current working directory=
 to any local user.
- [High] Unsafe file writing to a predictable filename can lead to arbitrar=
y file overwrite (Symlink Attack).
- [Medium] The `--event` filtering logic is broken and will silently filter=
 out all events.
--

commit 53bc6a67d41c378acf03d12753bf2e1052ed93f0
Author: Ian Rogers <irogers@google.com>

perf gecko: Port gecko to use python module

This patch adds a port of the gecko script that uses the perf python
module directly. This approach is intended to be significantly faster
than using perf script callbacks by avoiding the creation of
intermediate dictionaries for all event fields.

> diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
> new file mode 100755
> index 0000000000000..15b0198e4e1c7
> --- /dev/null
> +++ b/tools/perf/python/gecko.py
[ ... ]
> +class CORSRequestHandler(SimpleHTTPRequestHandler):
> +    """Enable CORS for requests from profiler.firefox.com."""
> +    def end_headers(self):
> +        self.send_header('Access-Control-Allow-Origin', 'https://profile=
r.firefox.com')
> +        super().end_headers()

While this behavior might be inherited from the original script being porte=
d,
SimpleHTTPRequestHandler serves the entire current working directory by
default.=20

Since the server binds to 127.0.0.1 and stays open until interrupted, could
this cause a regression where any unprivileged local user can connect to the
port and read arbitrary files from the directory where the script was run?

[ ... ]
> +    def process_event(self, sample) -> None:
> +        """Process a single perf sample event."""
> +        if self.args.event_name and str(sample.evsel) !=3D self.args.eve=
nt_name:
> +            return

Does str(sample.evsel) return the event name wrapped in "evsel(...)"?

Looking at the pyrf_evsel string representation in tools/perf/util/python.c,
it seems to use PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel)).

If a user runs the script with "-e cycles", event_name would be "cycles".
Would the comparison "evsel(cycles)" !=3D "cycles" always be true, causing a
regression where all events are silently filtered out?

[ ... ]
> +        output_file =3D self.args.save_only
> +        if output_file is None:
> +            output_file =3D 'gecko_profile.json'
> +            self._write_and_launch(gecko_profile, output_file)
[ ... ]
> +    def _write_and_launch(self, profile: Dict, filename: str) -> None:
> +        """Write the profile to a file and launch the Firefox profiler."=
""
> +        print("Starting Firefox Profiler on your default browser...")
> +        with open(filename, 'w', encoding=3D'utf-8') as f:
> +            json.dump(profile, f, indent=3D2)

While this issue might not be new to the port, writing to a predictable,
hardcoded filename like gecko_profile.json could be vulnerable to symlink
attacks if the script is run in a shared or world-writable directory.

Would this regression allow an attacker to pre-create a symbolic link with
this name pointing to a system file, causing it to be overwritten?

Would it be safer to use the tempfile module or os.open with O_CREAT and
O_EXCL flags to securely create the file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D31
