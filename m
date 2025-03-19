Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A5214A7D;
	Wed, 19 Mar 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415211; cv=none; b=gAmj1z3IuW0v+Wmqy4JaOC7wsLiB7+ESNuL9whFsEJL8bEY6rSZN9vd5ugVNKoU21bNjnnIToy2KWghK2I9zCiDe+MAPlHLhLMUZWJn9FxVcg4fj3ptGzmYqmkeCkhvU2eRmu4kaa//bclsqh+ILPvEKhmKQNlrmJ4gS3bZUf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415211; c=relaxed/simple;
	bh=IrE8OC5wJ2MYxS6DF3IvpZJmcocVk+5RoUy/wvCa+NA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Puwpb02Nv7Ws4pdPSECPCdbfc70Qi2GxpDJFHvC86Edg65ZcEhGi3Bn1tEqDhXuvsxKqflpdV1dhNvW/J+irWFpGRnnRI9+WnKYo4I0nzl+1aeFfKL0mrmJjIGUNoC0iXNtaRDfamnqqFZplfp5mI5enWSVK5ltlejGuqkaddOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0NnbIom; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0NnbIom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D879C4CEEE;
	Wed, 19 Mar 2025 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415211;
	bh=IrE8OC5wJ2MYxS6DF3IvpZJmcocVk+5RoUy/wvCa+NA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E0NnbIomf7642ol7dxyBpl9EeySZ7G90W1001R37tub4nhb9kJDTq2yIEAHuT2n8K
	 5C1KBFlqykeEPVhO04Ey/T0/zZ//2OB9Rrlf6eeBCYJWjOSalv/bPnrFXi/sZFJBCi
	 tV9WjQV7gCDlHVduLetbE9loCcDx+MIXcQpBEaASG+qvPGRg/Q3pNVmKYCS34qVT11
	 iJPcj7E1sjv2ltURZ8Cnk3aHO7Jo0o5oHExq6dqQs4eGp7vdOMgfB4bLGiySDVyp6+
	 f/fqDBHiDELQSX+8+sD7sothUrtv2m6TBwDjSUC4ot5HDcQPBOJ3ICTvdXs9gZLUNc
	 SkonU2V8ro15A==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 Feng Yang <yangfeng59949@163.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250314031013.94480-1-yangfeng59949@163.com>
References: <20250314031013.94480-1-yangfeng59949@163.com>
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
Message-Id: <174241521060.3133484.6737548483652591061.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 13:13:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 14 Mar 2025 11:10:13 +0800, Feng Yang wrote:
> When s2[i] = '\0', if s1[i] != '\0', it will be judged by ret,
> and if s1[i] = '\0', it will be judegd by !s1[i].
> So in reality, s2 [i] will never make a judgment
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


