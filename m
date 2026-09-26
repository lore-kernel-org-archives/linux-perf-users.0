Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A938B14C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404675; cv=none; b=UHoWOc0YGVilR3GaIovGIgN80IgyRrB9zSj49wI29ln9J4TvfDb5WgkA6/F+i25Neha8Q3F4j0ahje9x5KgDIRXjW4ZYEha3jUA+3V8tprlZLe5UZk/8h2tOkIzFYkM8wHKfBgqd1JjgG4LvOGQxRsf6Js8wNyKSF1m0zI+seHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404675; c=relaxed/simple;
	bh=ETCFsLf60qA1f0XnSONPOwDw5WRPj93PVclPmyxIcQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dFYpZVKY1afYTXpZkSeav/K1mtpW60Phwrp6PcQZPX2MBWzNDHj/C/w40S6BKxQ/0sDhY5wXN27RcJMZZ6qFjgAu3EhhG3FVqE7xzqfOWljC49/2m3/bXiJfCTxp2QpI7OtG4GWhCMPH75YRMcy/z2gIVEtjrU5BuuE7mFpTJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhkTp6Ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhkTp6Ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403491F000FF;
	Sat, 26 Sep 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404674;
	bh=fHTicairZGmv2QO//K2GfRcDa+uoghzPaRSSenTLoUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhkTp6NsVo+rbZYl7SvwgPvKkVNCbm7XiNgVVlO05NYN+O0Am5zCA+Drdp0kXWjjw
	 fl6fKBBcrHw5jsHnb4ERmaZd1LLdhnr78L5d9ocebche48NPKwLY8RqZZqBPttaO1n
	 7OgRfG/oEeT4J3csR7OX/ocwVvIyTAIIpQnkjQTJQ9o3dHApif990RkR4s+9B3Lyng
	 xI+ncW5dlliR40P7S+rRAscKiWqTwlDfvplmDxTjgD+sysozXeG5QCZ4OKz85yUsEC
	 NXBuE6r4+KJzQr184RS1U6DueoEv5y+Ed1W/tlLLlhp189IwqkT6U97GX3OuAagjvC
	 HnFi+HyrlTfow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 49/49] perf Documentation: Update for standalone
 Python scripts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-50-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:37:53 +0000
Message-Id: <20260926063754.403491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update perf-script documentation to reflect standalone Python script
> execution and the removal of embedded Python and Perl scripting:
> - Remove documentation for the removed -g and -s options and legacy
>   record/report script wrapper modes in perf-script.txt.
> - Remove references to perf-script-perl and delete obsolete
>   perf-script-perl.txt.
> - Rewrite perf-script-python.txt to document writing and running
>   standalone Python scripts using the perf module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D49

