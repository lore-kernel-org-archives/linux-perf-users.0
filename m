Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730F395D9D;
	Fri, 27 Mar 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645262; cv=none; b=i9svJjrGqPfktr4USuKLRa2E+Moi5T9QDSXeQePMP5vxrh3sXo7u1vSyyYMjq55frGlQL/HwSXz0Jup7msm+lsi333SLN+C4mFy/szy8RxniTzlsSD9NgYnP76n1JMM50HnTjeZSfKZckH2MP0HKA9iWRz4XG8maYfpqnXzbrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645262; c=relaxed/simple;
	bh=AYZ45EZUEiIeN+OmMcBetNjMC+Ear7KXx40bo0hBqNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G/iZgxfgf8fxYb7/i9P8gEiKH7m46OwLoIa77Fl0Bplvqi8g65hSjaw7LZQS7ky2jfIZfDNwNG34vnXp/dTdCd2pJXm4S+h6WrmDaEcAlgKXpE28iIjlLKqYwS7EsD36/yHniBtu2rXyyyu3ycpEo8kuCx49RmR4G2yysnOaaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VffPudEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VffPudEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E2CC2BCB0;
	Fri, 27 Mar 2026 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774645262;
	bh=AYZ45EZUEiIeN+OmMcBetNjMC+Ear7KXx40bo0hBqNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VffPudEB2lESHW0R3A4Ioc0GWyoZ9rvuF+KRUHSgBktjN3R1ST8wPlLe9+wt42MGu
	 Py8sJSxaj9VCLKu+W6/yiGo5Dn+Ryi27xXUsZY1F5Ss8RNHyK7X+RpSJJJCLWSZy9g
	 N7+avp6twWuWqBa69SG1rLGxm/Dn6X2UXlMwzE51YaGyXddewbpHpH4sWPXYNFxB4F
	 Myqm82AzB88PpyoffUcXbVgzbQEOYDUeREVksHzOC4F57DHM0uw2sf3bM+7Mdj9PGd
	 om45h0yU/DRH57Nf0UtMgeMEQssEs16C/eGDOcyVgzQ+5b0cb5A/MSwkt6eULXYIvh
	 IhVUFslWBOV+A==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, peterz@infradead.org, mingo@redhat.com, 
 acme@kernel.org, wangyushan12@huawei.com, hejunhao3@h-partners.com, 
 jonathan.cameron@huawei.com, Qinxin Xia <xiaqinxin@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, james.clark@linaro.org, linuxarm@huawei.com
In-Reply-To: <20260310040607.1780971-1-xiaqinxin@huawei.com>
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 0/1] perf: Add --pmu-filter option for filtering
 PMUs
Message-Id: <177464526194.2796353.17229996723744684105.b4-ty@kernel.org>
Date: Fri, 27 Mar 2026 14:01:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 10 Mar 2026 12:06:06 +0800, Qinxin Xia wrote:
> This patch adds a new --pmu-filter option to perf-stat command to allow
> filtering events on specific PMUs. This is useful when there are
> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).
> 
> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
>  Performance counter stats for 'system wide':
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


