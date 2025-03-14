Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028742629D;
	Fri, 14 Mar 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974222; cv=none; b=kjRvM2EiwhVnUvabC9qmxw5EmctH0SEex4dTEacveL6aQnvUP2rxj1MW1bjP2gX25+68b/jfUmHF5efi20EWWoskv6KSbL9TCu6S2gf4BhDempzRUrgfUP7A4dZevPejA+QNYy2YuW+k0zwHPvlYdRzByqgXtgea3xCksX/hLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974222; c=relaxed/simple;
	bh=UfJrm2yCFAgVvDAibstSIiqplSzCVgfdGZqcvC0TH/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hcf2Ppm1KozZdOFQX5yC/QFx+KUJgXerGgYRCwbxjgoK9C/bAHYa1a7jn//kiuPoB4VTRgZOVWcR7OvQCU3PDQerEm0apEW4u0gS7TPQv95pJg2gMIqtVlKdJ48LzrrFBL8qF1YRZAOdKmo6I7d7EttPQpPnfgWaS/PWilcsxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzdiXnLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzdiXnLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E208BC4CEE3;
	Fri, 14 Mar 2025 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974221;
	bh=UfJrm2yCFAgVvDAibstSIiqplSzCVgfdGZqcvC0TH/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MzdiXnLDnYiyc+IiiZC3WYzF3D4mo6tnnO1kek0ERsAdbr0I63piUX76szP1uEFQv
	 LQ3atwDzS6mIvsfhNVFwNjJSHdJlJ8drU9ZUbb+uUzptDyvGXqfi2WCWgHJYtM9m0x
	 Vk2ErzxebJgpJDcfbNdMD4ezLbwigmdt46NMXTk/Cip7PcgbIEwEHkQPQI+bDlgNB5
	 FaZZ3fTCNVEGaQ2plJXiHa+uVRfpz8g6tmXFN8+4G5J22yxw45hdXRSDKLtQoqTsJd
	 uKm9zP8mggbQscDuQ5vzyhbh7CWYR/BeGbb3erFFkc8qkqWfW4XMwgUqx9iv3hSLQJ
	 myOLVRANzrNkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yujie Liu <yujie.liu@intel.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, 
 Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com
In-Reply-To: <20250312075636.429127-1-yujie.liu@intel.com>
References: <20250312075636.429127-1-yujie.liu@intel.com>
Subject: Re: [PATCH] perf script: Fix typo in branch event mask
Message-Id: <174197422088.4059945.167819241578952524.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 10:43:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Mar 2025 15:56:36 +0800, Yujie Liu wrote:
> BRACH -> BRANCH
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


