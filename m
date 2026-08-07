Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AD3A5436
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113949; cv=none; b=PsByb/na1MKO2R532ORnAXwFp4uRYkpVW4G2J+D3bI1ki1AwXBA+JkiNM4azlSFacYQMYbcJIn2H4e0yz0+gQJgBKBKcyERzgG0Sl2PVFgtIh6HXhj7NrRCwhCSPbjfD7sdVQb3hauhJHoum54QK6IfZRpxbQEJ+R9g1A7I9+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113949; c=relaxed/simple;
	bh=J9UN2ZB9cKNJZZYIKWLt53J/gJkZW8x4yHEgh617+8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udsAs1Pho1SnYzANaD+7GoqNbG0+NK7kdZrUMAJlRyN/SQN8UyD1ykAs/8XVhurXHQJuArK3u+493CylXRRr0+7X+khn7qYShmR7q/xwBBi3YCrpWhZrdopMgdwA7/Ehzxtkmt9K4JGP0IWRdueotdku2SCZdHwyDHJNmP2d39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0EiHpzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0EiHpzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F20B1F00A3D;
	Fri,  7 Aug 2026 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113947;
	bh=DVzXpJ3wKLF2SH3NQSsjuyeYvvCN9WG9qxCFAHDAAOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0EiHpzRujWYSmUrQTVMkY3P1Zkc/fJFYARsnDQm/CxluVt5/Wra5vEt46DD81A/v
	 5ili7zS5NVidGWAnP3qArRx/nrUNNzkn6RTItNacB9hvYHJelzZ9csXRitnzmW25UY
	 CY4/uxJXAdgrMStED68vwl4bz2Skmn/MHYBPxHWMp+kWU9NYar2yhId/IqqGV8T+pA
	 ebKql1SQsoI+ZTjlVe7NN7mNy4lCBe/+9Turfulq8jU3Eyt0C5t3/nID0Md6/fI82U
	 suZwmBxb+8Xk5FnzCC31Ff7Gy8DYxcflDfVUdVZTjsY9rg0oeR490d1UEWU0+N7cwn
	 OauqFUpujJoaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 6/6] powerpc/perf/htm: Add documentation for Hardware
 Trace Macro PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807143734.1224-7-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
 <20260807143734.1224-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:45:46 +0000
Message-Id: <20260807144547.3F20B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Malformed ReST inline markup for output filenames will cause Sphinx=
 warnings.
- [Low] Inconsistent naming of the trace decoding tool ('htmdecode' vs 'htm=
decoder').
--

--- Patch [6]: [PATCH V5 6/6] powerpc/perf/htm: Add documentation for Hardw=
are Trace Macro PMU ---
commit f01dd0b2a68c8e69f2fcef07fa210282e973c5a5
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU

This commit extends Documentation/arch/powerpc/htm.rst with a new
section detailing the HTM perf PMU interface. It covers how to open
HTM events, explains the required AUX buffer size, details the output
files produced by perf report, and describes how to decode the traces.

> diff --git a/Documentation/arch/powerpc/htm.rst b/Documentation/arch/powe=
rpc/htm.rst
> index fcb4eb6306b16..42ad9924a7f6a 100644
> --- a/Documentation/arch/powerpc/htm.rst
> +++ b/Documentation/arch/powerpc/htm.rst
[ ... ]
> @@ -94,7 +95,158 @@ This trace file will contain the relevant instruction=
 traces
>  collected during the workload execution. And can be used as
>  input file for trace decoders to understand data.
> =20
> -Benefits of using HTM debugfs interface
> +HTM perf interface usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ ... ]
> +Output Files
> +------------
> +
> +``perf record`` produces ``perf.data``.  Running ``perf report`` on that
> +file invokes the HTM auxtrace handler, which writes the output files:
> +
> +- **htm.bin.nX.pX.cX**.tX** : raw bus-trace AUX data for node X, chip X,=
 core X
> +- **translation.nX.pX.cX**.tX** : memory-configuration records for the s=
ame target

[Severity: Low]
Can this formatting cause Sphinx to emit warnings? It looks like there is an
extra set of bold markup asterisks trailing the first part of the filenames
that leaves the inline markup unbalanced.

> +
> +.. code-block:: sh
> +
> +   # perf report
> +   # ls htm.bin.* translation.*
> +   htm.bin.n0.p2.c0.t1  translation.n0.p2.c0.t1
> +
> +Note: ``perf report -D`` prints AUX buffer sizes but does not produce
> +the output files.  Use plain ``perf report`` to extract trace data.
> +
> +Decoding Output Files
> +---------------------
> +
> +Pass the generated files to htmdecode for trace decoding::
> +
> +   htmdecoder <decode_options> htm.bin.n0.p2.c0.t1

[Severity: Low]
Is the decoding tool named htmdecode or htmdecoder? The descriptive text
refers to htmdecode, but the code block uses htmdecoder.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807143734.1224=
-1-atrajeev@linux.ibm.com?part=3D6
