Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899D1DEFF0;
	Wed,  9 Oct 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496509; cv=none; b=mo9BDDb/V2tCRF7xoIrt16WACVCzr82bCzHXdwET6nmBhuLDUI0JPnC/QBaFUVy55xCvY/wlF2FzN77KDd1+pGdn9W1uVGvR7KXTtk6Mkk3DHLhGa1CY4jbURozx8JbyjKh9jj3Ku81op+IkvZKIhV3VdDZfdcnhALnMLb0QA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496509; c=relaxed/simple;
	bh=qVypcyJusZfqIkMJqURXpy2iJSmhxpHjour6gwObVQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7vh/Upa6ZoGjV9Hi/B4SqU5GNSXJm1T3ppma6phqNL2fVQ5U+8i6vOFqTPYcPUzGEHpSzP4Bw/Vq/UhZt6lCIB6Bp9epq0HHzUkbjDvWAgfvwpJqKN/YaJC3zQ08IivQdatbZKn98ICxQqcgL4ZEeVhh9TexBcjnHTiHJTElqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHomzd6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHomzd6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32A2C4CED0;
	Wed,  9 Oct 2024 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496509;
	bh=qVypcyJusZfqIkMJqURXpy2iJSmhxpHjour6gwObVQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHomzd6lC6zmdGbndGWy/gDOv3nni3AHpPJyeeFGd3dc9pa3sLpaInnvrKeHI2EFz
	 tNlJ7c+jUAjLQ2hSO4l4uSDs8xKyRjXON/pGu0EB/PRGPl+owElQu3HNfAMqt/YA4s
	 b34DLT6Neg2tBEFc2FrRQclBbPSVkDwsTdNGdaFb6+bBzHZCSJkaR9xSBqQoUA0PXa
	 5eZ8kDu7hhrGLi0RZOPhUC57n40PmhrBXCbYiLMSHhuPZOUBauo8iPvZEnBLMnzOq4
	 E4N+VJ+imeaLB0t03qlxeITc9g1Gmz+r5T4lAYdeOuaawCdodSDJVOkzbmzTpXojIc
	 Xhdn5WapIFa9w==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	jolsa@kernel.org,
	linux@treblig.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Remove unused add_perf_probe_events
Date: Wed,  9 Oct 2024 10:55:07 -0700
Message-ID: <172849647450.828387.858038011301150376.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20240929010659.430208-1-linux@treblig.org>
References: <20240929010659.430208-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 29 Sep 2024 02:06:59 +0100, linux@treblig.org wrote:
> add_perf_probe_events has been unused since 2015's commit
> b02137cc6550 ("perf probe: Move print logic into cmd_probe()")
> which confusingly now uses perf_add_probe_events.
> 
> Remove it.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

[1/1] perf: Remove unused add_perf_probe_events
      commit: 3c4e558787f233044052ffd255a44ff7127952ce

Best regards,
Namhyung
