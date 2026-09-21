Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568E495AE9;
	Mon, 21 Sep 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013945; cv=none; b=ow6WwvW/eOmSAy2TjALitdzMMpZJQFJz3QgMa1o6tNbKajApmqO+JIbRb0gZ5aN6fp/9091ZwvKuiObAnQz5BorfBFyrlMFR2wL1MyTrVSCUC6zK8EMjjV5wknpXd6biKloChEKI4pLxVTzd53ow19mxpyzHDf/JcUhTrA78thY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013945; c=relaxed/simple;
	bh=3qAzwRYhEtoZlWs6SHp3Xys4KwvefLJI/cZeSD2508c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTK5MLMrPjIJ75DaTsKKzJilLgbsxCOKAJJZWzOoWGh8uHYL3SwEPepYr4r5QRchc+0RE9I8OVjMbLXnLqFknwcNVrGqa3SWUSlDc0ZO4SGyQAPpAAtLE4KN7WrqnVqprLlmBrrpMZ4pOY2dUsx+SZZrIIZJ1QdXAEjOTzs7SRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlBt/bMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlBt/bMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064DB1F00893;
	Mon, 21 Sep 2026 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013944;
	bh=A0NsX+3Pmr+MxRy4hePziXv5Tnchd/wN6VKgO3Tv+l8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlBt/bMp9rBFlPbs6IbYBIuFXOFUZcf0De/C8MZlpgmH6kw5mny6J6kDgTM1lR/Js
	 bpMgPEBPGkvt7GyHBMe1HE7aQENJzEGsWz9S0odY5mWVIDkqzsTcaUREkMxq17ejpG
	 G6iwvG4t4IiUe1ax+NNeQ0eyJh5xpq+Iv9VTv8E9cWUnU/Opr/xnzWkSPCJp0udvF+
	 mheskpKZY/ZEnAQ++V/BxpGniU2nHUU1Pq7UTxR7hgrrVI7XGJ4xMTFPg2pgFU9efY
	 QHm6mz8zoj+bX2vTOy/3roWiBai/Yu8P2lgpHnp90G3NCxCNGpKsvgBktzCFX+87k0
	 X6LPr8/gMqKgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf tools: Put Python bytecode in output
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921175719.846883-2-irogers@google.com>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
 <20260921175719.846883-1-irogers@google.com>
 <20260921175719.846883-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:05:43 +0000
Message-Id: <20260921180544.064DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: root filesystem pollution or build failure due to stray sl=
ash in PYTHONPYCACHEPREFIX
--

commit 3de8bc01d44a9b11e10c327ec26bbff8605926df
Author: Ben Hutchings <benh@debian.org>

perf tools: Put Python bytecode in output directory

This commit sets the PYTHONPYCACHEPREFIX environment variable to relocate
the Python bytecode cache directory to the output directory during out-of-t=
ree
builds. It also updates the python-clean rule to remove the new cache direc=
tory
and perf.pyi.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a0b23d20d005c..50bde95c78a54 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -397,7 +397,8 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
>  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
>  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> =20
> -python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
> +# Put Python bytecode in output directory
> +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__

[Severity: Medium]
For in-tree builds where $(OUTPUT) is empty, does the unconditional inclusi=
on
of the slash cause this to evaluate to the absolute path /__pycache__?

When Python 3.8+ runs during the build, it appears it would attempt to write
bytecode files to the root of the filesystem. Could this cause a regression
by breaking the build with permission errors for unprivileged users, or
silently pollute the root filesystem if executed as root?

[ ... ]

> @@ -919,7 +920,12 @@ $(INSTALL_DOC_TARGETS):
>  ### Cleaning rules
> =20
>  python-clean:
> -	$(python-clean)
> +	$(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)__pyca=
che__ \

[Severity: Medium]
Since $(OUTPUT)__pycache__ would evaluate to __pycache__ in the current
directory during in-tree builds, would this fail to clean the incorrectly
placed bytecode directory at the root of the filesystem?

> +		$(OUTPUT)python/perf*.so
> +	@if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)python/perf=
.pyi)" ]; \
> +	then \
> +		$(RM) $(OUTPUT)python/perf.pyi; \
> +	fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921175719.8468=
83-1-irogers@google.com?part=3D2
