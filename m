Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FB372661;
	Tue,  3 Mar 2026 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576319; cv=none; b=KtAN27R24JwGw1OjhgUldCrPjcD9xf+au88zWb+ObYuIbnlKuPNlWqfW3bVRw1mMrIQm9BHlw9c2B2Qec08yQu8zgzx27Jro3oC9NDV/pIRzkTntvv6gTcNywSKV2CPeIYS4oCaaJdYSNuhwce6YcBHYafAS80BlqHyCnGIMujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576319; c=relaxed/simple;
	bh=FQGdK/3elC7p+bqIS1PiPw+MXc0KOUeJHq3fHYiwJ8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DOY6o9HxK6Nmftd+eBrTJl66F05mGHg4hei+3Y3rvVZ2WRumjhXtUhIrXYpb9lev5KY1qgNIrtS4Gyyw34GHocSa+srusYU2YJmaiLT/vkT9aLTsMnmNyvwxg0Q/Jfj0IPk6VfibKaDyQcPtQkQMWdp6cVU0PLj/h7y1GgFP07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agOml4O1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agOml4O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A325CC2BC9E;
	Tue,  3 Mar 2026 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772576319;
	bh=FQGdK/3elC7p+bqIS1PiPw+MXc0KOUeJHq3fHYiwJ8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=agOml4O10k2Vo1IEvgE/mFSKFy8Q+7aRxjCDc42Cj/uUOo7pt8slfPDfUGDPn53PU
	 7Dim0kajXkzR6zf6sfRy3lv6aH+rdiQXlCRHX5Q4YomYZWxGzmQXmeorvYlSQ+KQNJ
	 rx2hO8BGgtUafUzQox9e5jG+gS2x1yG+ToxiU0Lye9ORe/bWcx4Yqj+rjAfV9IyehW
	 FCo4ymIBSX04QrO6DQSIRwJiP4+VhUttqfwGNW+txvEDKCnayBUYB2q48uaYGThZ7c
	 4BgpHtwxKg7DQcuQp0OhHBBS7xtM3EXRvtdgd3FGVigZmo0/83wKRPzgZA1aad0rr0
	 4TX7ySN89wbjg==
From: Namhyung Kim <namhyung@kernel.org>
To: howardchu95@gmail.com, Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
 jolsa@kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
 peterz@infradead.org, wangguangju@hygon.cn
In-Reply-To: <20260302234515.565623-1-irogers@google.com>
References: <CAH0uvohLdUS6ODLZSKUA4FvjwGeqi3=9H-fJ94ybkzZPuGJ3Kg@mail.gmail.com>
 <20260302234515.565623-1-irogers@google.com>
Subject: Re: [PATCH v1] perf trace: Avoid an ERR_PTR in syscall_stats
Message-Id: <177257631862.2872307.8742084951961095200.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 14:18:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 02 Mar 2026 15:45:15 -0800, Ian Rogers wrote:
> hashmap__new may return an ERR_PTR and previously this would be
> assigned to syscall_stats meaning all use of syscall_stats needs to
> test for NULL (uninitialized) or an ERR_PTR. Given the only reason
> hashmap__new can fail is ENOMEM, just use NULL to indicate the
> allocation failure and avoid the code having to test for NULL and
> IS_ERR.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


