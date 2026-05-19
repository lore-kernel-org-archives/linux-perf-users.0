Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC436407CCB;
	Tue, 19 May 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204243; cv=none; b=u38CvPwKpS01uAVkkZJWSEBTai52j0rBDjkI1tLdaeG2qW5dtd1kLE0xlHeAd4qQwHAjfdM/XenNOLRTIhMo/qtYWmCzT8cDGFCjBGQO2e0tKW+/K5MBY0PeqcRc26QLW0metZqqvRukCTdbtXtGyFXX1ARYgNzu5mYJkWbA2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204243; c=relaxed/simple;
	bh=ef0V2qYtMoTZ4ao0OA/ZUH8o36Z4suzNSkCZvD+JjiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htagEBPJprLMNlzXcMuyCzhXJB5ld0JYNomtXjXjK9VSiVBMdig17nld9zkeUYhSR1OT/hsbuehUx/k27gssgSzhy9nTvJcDHRyWCx3fyRwaPiK+P4s9uqN54Ln589FNdVH5S6IyKhDTu3t99E/8CK1RsOr0g+oThYhoWrbdlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHKx/dRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHKx/dRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67300C2BCB3;
	Tue, 19 May 2026 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204243;
	bh=ef0V2qYtMoTZ4ao0OA/ZUH8o36Z4suzNSkCZvD+JjiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHKx/dRcVU1ErmNRFu+mNLcqMBYsntNVurMdQbJapJq3gfUpXv1UQ0Lq2JYpxqY24
	 kPx2PcjzhB5NYuxX7p5dsx+CTYxLnQ3koGMFOiFtNLNeY7IkJU8URxsDVkhk8Rlc3g
	 U6kN2PBa3jeCW2QnA0aVCdsSd1f8sWZK/WqkY6j+/fphWVM2POwxdFHbGjbqE/PoGV
	 X4KduLkmIfTkhz3JfJh3e67kdmzExX5oPkuKIr8wJQt3sfshBbcUKQFSZyc8g77ulz
	 Xl7I6mZK6S9kikz7jWOqyNj5wK3DoNZ2l00gW305woJjWDpRVKWnZCOk3hsR26Kqv9
	 2Vb2jstowzFdQ==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	=Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] perf: qcom: Unify user-visible "Qualcomm" name
Date: Tue, 19 May 2026 16:23:02 +0100
Message-ID: <177918680676.737622.2620851169920682514.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427070056.18140-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260427070056.18140-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 09:00:57 +0200, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: qcom: Unify user-visible "Qualcomm" name
      https://git.kernel.org/will/c/3ef020a3c9eb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
