Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7A1DE3A4
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070157; cv=none; b=mr/Jd1WeoyYYpLiQJKxVn9jwkBiUgn08LGYP0xEvruqkwYzqaqpbvA7hB79CrzmzcDA5MMH9c+FDqq6VI609yvO1nHFYxvfHPuTR8ipja/noJIg/Lws7tOpYm1+E5IvzyKSbLTRRg0poPdtavRFA8TAWxyX5Gy8Yfy0zXT53zIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070157; c=relaxed/simple;
	bh=jKWFHaBLEjHpq3afTcstJYnbMQnwr0AQCoA2929YLpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lZF/z0uakKTnItcDfVH0nR+uSCjfHgaBh8eurxupGYoR6q1f+I6yuuG7AdREbfD0SKQ5wVX3iSVVYozLcSvt68Sie6KrsNgc0Ol43SyKEvboo4S749tQCQlKuwO8u+a4GUwrOZiy9f0YvVtVMXBjchVtx/P6O0WYL33LXgdqV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/1PkIGA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/1PkIGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC253C4CED9;
	Fri,  4 Oct 2024 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070155;
	bh=jKWFHaBLEjHpq3afTcstJYnbMQnwr0AQCoA2929YLpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h/1PkIGA5S7nBaOIQQHgWyxxmYxH9ulUiFY8BQpOYu7J+NUFLDmEPN8uiXG2QZ8ID
	 1mo6Uw7J1Nj6Tb4a9Zh80lsKddV/847tjUzx/+Q5P4VCd23pmn1Zx3VoZHYr7hsaR2
	 vZt3D2G/H+TGxX64jjXlm0FFTyB8ceyPTEaIE01vHNKlRMx+eFeYuQACDoObpXufRp
	 gqGFCKRqEQGMdLSKwRMxJVXkCiXyjs1AyW46MFLgtf48JnL7h8VBjwVZllHBLIjjEy
	 zn8MAzb9m+5npRyu+VICnXiQTR/oM6eA4tlcrNGHM9y6jQdkcxQejqAmm4DW+7oVde
	 n+b2JjB1X63hQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
 vmolnaro@redhat.com
Cc: mpetlan@redhat.com, irogers@google.com
In-Reply-To: <20240311081611.7835-1-vmolnaro@redhat.com>
References: <20240311081611.7835-1-vmolnaro@redhat.com>
Subject: Re: [PATCH] perf test attr: Add back missing topdown events
Message-Id: <172807015572.55364.16730066776876656675.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 12:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 11 Mar 2024 09:16:11 +0100, vmolnaro@redhat.com wrote:

> With the patch 0b6c5371c03c "Add missing topdown metrics events" eight
> topdown metric events with numbers ranging from 0x8000 to 0x8700 were
> added to the test since they were added as 'perf stat' default events.
> Later the patch 951efb9976ce "Update no event/metric expectations" kept
> only 4 of those events(0x8000-0x8300).
> 
> Currently, the topdown events with numbers 0x8400 to 0x8700 are missing
> from the list of expected events resulting in a failure. Add back the
> missing topdown events.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

