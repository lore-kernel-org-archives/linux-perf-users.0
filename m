Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856F18039
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251460; cv=none; b=QGt0UPlPF5X7fC/+K69y8HbeDJrTToA93LCNBBmO1LTw+Do1tIKI/FLEOr6yZntTrGIfvXd3jZwxWTEh31w2UgNmNg6/D2uHCN6qt13s2+iWnRoBybbIu7HdWtc7HWWA89SEHpGKPnvyFT04yaMtVsrqRl79QtFgjhnddzrekj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251460; c=relaxed/simple;
	bh=U2+Euuq93WaBf1QXjBE9URCm/VUm5/fwg5qVDBFqtKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYOxXQgK3oJkx6QGUXrl6l/WBjdCrf/+DMvSLh4XfJBO59HQaldKjXamuPzDJ8SE3jUGML7Sc7I4epy9SFKhM8SoB66C3p1qcJfse3plInBlGJKZxkKgkKj3ryvNF5XTYXU4PTn7qTs5u8x240kO8Gj14lHBr3luWp7lHwyiSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4Wfv/0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4Wfv/0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9755AC2BBFC;
	Mon, 24 Jun 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251459;
	bh=U2+Euuq93WaBf1QXjBE9URCm/VUm5/fwg5qVDBFqtKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4Wfv/0wfHQBuWnEOK3D1jdeazr/Voco2IvbwKHck5HDASNkm8EM5YjRPICLg6Kbu
	 o7nDpuWeQ3/rqqydCe13+WwBZJ6w6edY6byX49sWrZByttXoaUU3Qnp4msyal0Aff+
	 +4tGG0vxwXA4W/jgcSiAnbha9zeLA2BggAU15w7yFGcWdY61pjkO3SPQ+HBr0fUwdb
	 OgKBIf9O78HuhEzkEoDB2Qn+fFWDHYem2XqDLPRTHnIrimmtar/WkcVrnxDGrSDcw0
	 zgD7y3eQeZNqV7U95Z31u2x9sj4i0hiPB1V9p+L0uDyceKisNOuki3buSI1GrP/g2g
	 12kfIwcKgPRWQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	amadio@gentoo.org
Cc: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for libtrace{event,fs}
Date: Mon, 24 Jun 2024 10:50:56 -0700
Message-ID: <171925142502.1926937.5367954849470450249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240606153625.2255470-2-amadio@gentoo.org>
References: <20240606153625.2255470-1-amadio@gentoo.org> <20240606153625.2255470-2-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Jun 2024 17:33:01 +0200, amadio@gentoo.org wrote:

> Needed to add required include directories for the feature detection
> to succeed. The header tracefs.h is installed either into the include
> directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> into /usr/include/libtracefs/tracefs.h when using meson to build
> libtracefs. The header tracefs.h uses #include <event-parse.h> from
> libtraceevent, so pkg-config needs to pick the correct include directory
> for libtracefs and add the one for libtraceevent to succeed.
> 
> [...]

Applied both to perf-tools-next, thanks!

Best regards,
Namhyung
