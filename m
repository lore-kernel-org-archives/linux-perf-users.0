Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC833A3E95
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249801; cv=none; b=E3HZ3Ub2osDGzV5hf6rUzC2DvaXLWlv/zUjDVav4e3lM73CNTS5w4K2pTifhoIesHBjJe3FMngkpi28LYR01mtkiWGT7tNPCTljUNuPCG+SQpgO7oeyoqmrYO0+p8xR5R0HzVTLMD/a6+rlG/2lWm25Sh8VO/twFdbUEklbaq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249801; c=relaxed/simple;
	bh=h4KyfwO1aG8anJLCQCgHd/9pi0rfWit6g8MGsh6CsAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/bQ2oHwHkcM5zf/IsuenoBzuNzLhiPsZ0Lv26XuSUaTkfJ9lsDpO8OhTmzWlBgX4hAquFnJU5OdPqCg8XlVwwfw3MVwoDAyo5l61KSLs/c2+T0fvA+psLk24mPaDoNeUQdTdcoNxyw/zgwE3osfe5CaIEknxtCO+75KdXCKYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq80A72Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq80A72Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0651E1F000E9;
	Sun,  9 Aug 2026 04:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249798;
	bh=bJSC0N8MMWmXGNSbFHo6sqVaaWcLDtba6ePtAbVWCf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dq80A72YBPoU5hUNx1/jjIsulbOJ2TGxU0ERTywlYHIwzRJr37ifYTz5kaWc3S2wO
	 wYkC2PK9X6WdE5/dT8QY8XRDV4nCqEsRWj8TKYjdwguJc7KWJYmHjLuWhJ2DJkYlMP
	 KO5gvbSdrDk4Y+O2t3zPgbxUVRHiTjR215FN1aXVyvpdMbtH4JEymt2cnQxka3ZNmb
	 EyD5dOJg2IKgoFRwKepGwGWwylY4zZyPvwG1ltVNDQA1hqLUdATrGXq89EHAooD0VA
	 q5NH4y9K2twjoiXsQJtlZ8D+bDvVUWEIgyjR4wJR6uwnxPZ3JDvwASpHe+1QJ9A2KB
	 C0f3O7vfSAlbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf python: New treport script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809041638.2402705-2-irogers@google.com>
References: <20260808065743.2328212-1-irogers@google.com>
 <20260809041638.2402705-1-irogers@google.com>
 <20260809041638.2402705-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 04:29:57 +0000
Message-Id: <20260809042958.0651E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The script relies on missing `perf` Python C extension APIs, causi=
ng immediate crashes on import or execution.
- [Low] The argparse description inaccurately claims the script creates fla=
me graphs.
- [Low] Typo in the source code comments ('profle' instead of 'profile').
--

--- Patch [1]: [PATCH v3 1/2] perf python: New treport script ---
commit d9d175087e8fce3c5649b6249af90e23002fff56
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf python: New treport script

This commit adds a new treport.py script that uses the textual framework to
display an interactive tree report of processed perf samples.

> diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
> new file mode 100755
> index 0000000000000..528a640e4d356
> --- /dev/null
> +++ b/tools/perf/python/treport.py
[ ... ]
> +from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
> +from textual.widgets.tree import TreeNode
> +
> +# Global session.
> +session :Optional[perf.session] =3D None
> +

[Severity: High]
Are there prerequisite patches missing from this series? The perf Python C
extension does not currently expose perf.session. Because this type annotat=
ion
is evaluated at module load time, running the script results in an immediate
AttributeError.

[ ... ]
> +        node.value +=3D period
> +
> +        if sample.callchain:
> +            for entry in reversed(sample.callchain):
> +                name =3D entry.symbol
> +                if not name or name =3D=3D "[unknown]":

[Severity: High]
Does the Python sample_event object expose callchain and symbol? It appears
these attributes are also missing from the current Python C extension, which
would cause this to crash when processing samples.

[ ... ]
> +class ProfileBuilder:
> +    """Constructs a profile tree from a stream of events."""
> +    def __init__(self):
> +        self.root =3D ProfileNode("root", parent=3DNone)
> +
> +    def process_event(self, sample) -> None:
> +        """Called by session.process_events to update the profile tree."=
""
> +        ev_name =3D str(sample.evsel)[6:-1]

[Severity: High]
Does the sample object expose evsel? Similar to the other missing attribute=
s,
this seems to rely on Python C extension features that are not yet present =
in
the tree.

[ ... ]
> +if __name__ =3D=3D "__main__":
> +    parser =3D argparse.ArgumentParser(description=3D"Create flame graph=
s using perf python module.")
> +    parser.add_argument("-i", "--input", help=3D"input perf.data file")

[Severity: Low]
This isn't a bug, but the description says "Create flame graphs" instead
of describing the interactive tree report this script actually generates.
Is this a copy-paste error from another script?

[ ... ]
> +    except Exception as e:
> +        print(f"Error opening session: {e}", file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    # profle.process_event is called for each perf event to build the pr=
ofile.
> +    session.process_events()

[Severity: Low]
This isn't a bug, but there is a typo (profle) in this comment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809041638.2402=
705-1-irogers@google.com?part=3D1
