Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270A26E6F3;
	Wed,  4 Mar 2026 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660934; cv=none; b=GbsU1e1n9srB5IsfAII7plTpuYKj9g9MSqZXGJgyiz/VJLHg7KdObs2Q0bF7kiQZ7iDLYy86Y78TN7foZ8xmskRx+EhAkh2o42bCT37u3jrMMpV70mk9m8XS8kXkaW7vj1wPis+Q7f5MSr07jGnOiZtb0X1OAy7FkY7zKIpXRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660934; c=relaxed/simple;
	bh=vEJ7VUmLpt7i8idbC2tr4DLSU9hXU00TncSKznlyEIY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e39WyhzNoMdVMluIqhuNXtuRllrpK8IxujIQ8eFuuL8b08CiiotqGc2hSnCJYUvAuhxEnkEsVLmzNgy9s2Pdo9eYaIbPzuNxHMk6L0ECsJt7tw7t/aJ3UhzayrR7k0eqzZq/aq1TIGSCeRcDo6NKC5uy2S26Xz/r1bjTNO8dg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG1Imk6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG1Imk6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ADBC4CEF7;
	Wed,  4 Mar 2026 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772660933;
	bh=vEJ7VUmLpt7i8idbC2tr4DLSU9hXU00TncSKznlyEIY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DG1Imk6AAGJ/ibtF0iF4WVgklqlpdAcudHeK3BilPhTwDV1s1sM8yQq1tG5LqnoGy
	 7QjhRSrtlDB227Ty81Ua4gMLkn0goYaiOsMm28f4nIhv/JN89GlE2UqdkjhCM3eKLq
	 P5meHm4QEeHKAmsOkdZ+fyhAwquVPt9q7YDgU7IO1zz4bPgImeOb3sjaSk2Ig8GEsT
	 Q2heQ/PZ+PqYiQ5b3GXxXIHxa3xXaofB1H5CF59zZn6WSdSw9qnrklb+NKJiNt0zD8
	 rWPrgY/F4F5LVHvf1IGp2vEPGWIHdD3wa52utjhpTMMj08Cp4lWMx0Nh/9K+zrpl1I
	 hYT3h1Zu1Kz3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 GuoHan Zhao <zhaoguohan@kylinos.cn>, 
 Colin Ian King <colin.i.king@gmail.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20260303185216.897944-1-irogers@google.com>
References: <20260303185216.897944-1-irogers@google.com>
Subject: Re: [PATCH v1] perf pmu: Replace starts_with with strstarts
Message-Id: <177266093321.3626597.9849967840468280676.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 13:48:53 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 03 Mar 2026 10:52:16 -0800, Ian Rogers wrote:
> linux/string.h provides strstarts that matches the starts_with
> function. For style and consistency reasons remove the starts_with
> functions and use strstarts.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


