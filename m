Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370940DFCD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646504; cv=none; b=QDWyD4sWd8m4eO7jcj4JpZmMFUJRSMTcINUBVODECz6ssY/zu3LQD8r5+svPewQ2eG4weuET5O3v5zs3xwcRR90GP0WoE9yW6zj13DZe/nPiBvk2dyFwJ2q6hd6k+rcaSWeAUUfGRZwZvtfa5WuyLJGmcdszl8fkDR4TmQ/XlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646504; c=relaxed/simple;
	bh=4xzq5ZtLZkktTzH4M3dsC+ah0dzshPw98U2kvnXyMqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dh5nS8S/E2qwAUTxrGcIomIF7mqJDjjSxyB9RpSomAi8nuVHGp6YviNJtBZCgPS3L24f1hW5mNtcPeS146+nSHBPIpqNIhot+3sQQ6i57cOPB5T6G6kMFN9l3wpMhS9pUgUyLUPGfbbLy6jzbak8FAEXhpGf+p3ZugQt9NXgIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2HclBo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2HclBo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC7C2BCAF;
	Mon, 20 Apr 2026 00:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646503;
	bh=4xzq5ZtLZkktTzH4M3dsC+ah0dzshPw98U2kvnXyMqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=c2HclBo4QZhx4oQjdQJeoPwnpArBqyYYLB9KuvU3VqAgrYOibUCnQB1fWybhMrDAt
	 NkUXA+S4YA8sUxgRYydPY7d0tTn9C3vBrHZ1JEm4eK9aFsX7r7FhnVCghuestVWmq/
	 HYjC8wliFTELjfOaJwMdLIQKMmeSnP77dyW6rZvwxo21+HEn5s6zEMDUAN7ykaWjZb
	 /ES5VHqKFAKX4+PC7s195kRiqMCrv0BjELiDBs3OVw1uJBF17tMUhRxy/h0gKcj4RQ
	 xtRVpC/Jn6ds2NT5Zd04qeQHTGY1/B1ZKtEuCYgUeecc4D0Pv4fh1yYjSGJvPtNr7i
	 w9+K69ZXZUH3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 53/58] perf: Remove libperl support, legacy Perl
 scripts and tests
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-54-irogers@google.com>
References: <20260419235911.2186050-54-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:55:03 +0000
Message-Id: <20260420005503.C3DC7C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Removal of `#ifndef HAVE_LIBPERL_SUPPORT` in `ui/browsers/script=
s.c` causes stale Perl scripts to be listed in the TUI.
- [Low] Leftover `PERL_EMBED_CCOPTS` reference in `tools/perf/Makefile.conf=
ig`.
--

[Note: The standard inline quoting format has been altered to a free-form
summary due to automated recitation restrictions.]

commit e330ce2fbe1ba45b7d622aaa65d046ff6d7307de
Author: Ian Rogers <irogers@google.com>

perf: Remove libperl support, legacy Perl scripts and tests

This commit removes embedded Perl interpreter support from perf. All legacy
Perl scripts and related tests, as well as the build rules and scripting
engine hooks, have been stripped from the tree.

Looking at the changes in tools/perf/ui/browsers/scripts.c, the find_scripts
function used to skip the perl directory if HAVE_LIBPERL_SUPPORT was not
defined. By removing this conditional check entirely rather than making it =
an
unconditional skip, does this allow stale Perl scripts left over from
previous installations to appear in the TUI script browser? If a user
attempts to run one of these leftover scripts, might it result in a
confusing error since the execution engine has been removed?

Regarding the build system updates in tools/perf/Makefile.config, the
configuration block that previously defined PERL_EMBED_CCOPTS was removed.
Are there any leftover references to this variable, such as a dangling
detected_var macro call at the end of the file, that might needlessly
export an undefined variable to the configuration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D53
