Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C534250E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404978; cv=none; b=gMlz3FFRdoj6Rzf2PdAF/1lzuOtSGpdrjAhi8QKhrbGPJ6ZoO4Q+/IsXbjlWoJYOeP8+OhJvRh6rI7xLFkCOIfS33PGJk5QNL7IezR61cg6V9mMwTDv1+QIWzEIlU6Anh6PwjoAR1Xc7VhrfktdPTO3X4fN7F/s5s6ECbZMrEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404978; c=relaxed/simple;
	bh=eVEb+XOeWOuSdMVsS1okfgkiGpeBBik61VWTWuoay1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzCm1QwKLs23vyW/tuq689nmZV5Q931Ie+LmVwAnLwCfwxEQv+hx2RqHWpmUtOMkhIrSYH6BvRkLpY86hITx9LNNKLnquf7+5lbD/41bObzAAFGHUal8uh059caqR6zhOxWb1PvWCoIH5s+7hUIInIfYnC+NJOuKmmu4aRlrYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8II63YD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8II63YD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C600D1F000FF;
	Sat, 26 Sep 2026 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404976;
	bh=+GIlHUqGenJxrdsUjB9N62j3xZrFLk++y4IAkOzQPeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8II63YDtCdhg0EE4Q6HUQckhGN+oswnGsJoHM6Ae4dwTRThOhrXbQ+kGDO2Gydc1
	 KiNa8cU+/80zRbspmiHvMyQX05adyellvtrrTgQukY71NBGZInYzdNaQWQI+5haHjo
	 7qMlVi8ZZHwYg8CCii9dRWqZrE4bY4hKv1JNbpONZVozu78cfOzLZ9OEyqjagbrppP
	 t2hMLMYnBzaGl4EHWDUqmxxNlYjgl8wLeWHqI7DxvWkt9bjFj4AGH4rhh/AXSVzUVj
	 ex8hegC/lFVDi6obJlY0tw4iVL0hDCnOwK+NDd5+Nt5gDBbqcGSBMJ2oF5lYFYTaEG
	 c6XkeL9SQ/mkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 48/49] perf script: Support standalone scripts and
 remove embedded scripting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-49-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:42:56 +0000
Message-Id: <20260926064256.C600D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Refactor 'perf script' to launch standalone scripts directly via fork()
> and execvp() and remove the legacy embedded Perl and Python scripting
> engines:
> - Remove the embedded Perl scripting engine
>   (util/scripting-engines/trace-event-perl.c), Perl scripts, bin
>   wrappers, and Trace-Util library
>   (scripts/perl/Perf-Trace-Util/), and script_perl.sh test.
> - Remove libperl feature checks from Makefile.config, Makefile.perf,
>   builtin-check.c, and Documentation/perf-check.txt.
> - Remove -g / --gen-script option and scripting_ops dispatch table from
>   builtin-script.c and trace-event-scripting.c.
> - Hide the legacy -s / --script option and update script discovery in
>   find_script() and list_available_scripts() to prioritize the system
>   'python' directory over bare filenames in the current directory.
> - Update the Python script shell tests (test_arm_coresight_disasm.sh,
>   test_task_analyzer.sh, and test_*_python.sh) to invoke scripts via
>   'perf script <script>' rather than running the Python interpreter
>   directly on the script file path.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D48

