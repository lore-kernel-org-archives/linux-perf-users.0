Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A04A18;
	Wed, 24 Jul 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852719; cv=none; b=du1MJc0z4FRjd1FpaDL+3nJMbqLDr4CRnAsLe3FtTRpd2vFJDB/4sWkLsrjvYuV0GfgG0caPlROBCpd9aH1YVz2ZOAqD+073Q0PnFpz0MRyBDwX5eD90zQ4DnQSAFRdtaedmuw9l6H+EbQicoC3UCyhh/tZpZ1MNO4NQg8EBmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852719; c=relaxed/simple;
	bh=2jDvLNGYj3wyEPwVBytEMhstinz/gfZBI+USiWjORnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJ3pvb8npgcLhifpP+l9R9T61kk/zUp6THpmm2vL3Li3esEdrb5+2kzt0tA8CRCBpBC7XaSntB3ffs1chN++4koMj/XmEj1mMBucPn0d8TyDOiQfuVsWRMSe2fpRLWKPa1MXCXv1C4aQVsbC27cMQEJAX7RAAX/w4qHmzPF8UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj/Mtd6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj/Mtd6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D336BC32781;
	Wed, 24 Jul 2024 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852719;
	bh=2jDvLNGYj3wyEPwVBytEMhstinz/gfZBI+USiWjORnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rj/Mtd6+SS8IpNukb2ncyOiMAgRXqQqtDKyHCniQu9UwaUlatuNo/cWz9jp1PYEbI
	 Mbz5zVSUFVJjeihOXpJCzxD6zwBemzZ2WBZB1YAIvS3sv4rgShqcIn/Pu47rYgWJ03
	 +zp1WAfJLB0tv6lH0FT9vXMXy45QWh9klfg/pMh1lBzW2TkrO0GGiyqYkWT2wrbVxI
	 Ug6dHaP/XZemHsWcsxyZgujl7n74uFvWFbma/IRuzCQ9Fyrr1hyL+/bJAKug0Ves0G
	 4HKmVASeyTIOep3qL29xRQtdW1JdOSnrluMawZyPHa9uoRFIRZo9h1zRcuyw7bLckj
	 zx4ngXmpE9Wew==
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature check with pkg-config
Date: Wed, 24 Jul 2024 13:25:13 -0700
Message-ID: <172185262520.1508393.14480813167793131338.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240712194511.3973899-1-amadio@gentoo.org>
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com> <20240712194511.3973899-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 21:40:45 +0200, Guilherme Amadio wrote:

> Here is version 3 of the patchset. I see the change to send output to devnull
> has already been applied, so I am submitting the remaining work only.
> 
> The difference with previous changes is that in v3 rather than add tests with
> pkg-config to check if dependencies are actually installed, we just set the
> flags and send any warning to devnull. The change that remains in this patchset
> is the fix for the other tools, which were inadvertently broken when the include
> for libtracefs changed from #include <tracefs/tracefs.h> to #include <tracefs.h>
> since the flags for the feature check are not set in the other tools Makefiles,
> it currently only works for perf. I recommend to either take at least patch 2/5
> that moves setting the flags to tools/build/Makefile.feature or to revert the two
> patches that have been applied. You can easily test the fix with the commands below:
> 
> [...]

Sorry, it was a bit late to send the message but it's applied to perf-tools
and the mainline Linux now, thanks!

Best regards,
Namhyung
