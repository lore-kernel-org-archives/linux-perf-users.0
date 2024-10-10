Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F62A8E5;
	Thu, 10 Oct 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575517; cv=none; b=Xpx1E0IJXYO/DLpTvHLDJjQtYSdRyCYbIbOFowxHpctBfVY10KqnFbkwbBBqNV0B8GusNkyKldluu8Ur0QQl48JnIlfmXhEYwJwFKKFK838Tk0zhuTYOyvLyVY8sN1f3coBLBfQv1QCCK/hLKHK+v2zvE5qJ5lozs00JpFqNl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575517; c=relaxed/simple;
	bh=9IfOKTFMuHxxcYNIEM0Z3+cvEbDsgPRaUT941c6hTkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP9o9s2O9nLTzWIcTK6hhORucGsypdlORm91pxY4ZXg6k5p/DGFW3yaxY3uczCAp7cbiW2VFd/V+h883jlw4RQl8ToWuBgB5iC8AbLM6gH1VqZ81UR7brf0PRZ1NWWzWXq8bTkf8oveai+4UdB3e6JQVpcVb3GUclACfdwGjlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZcvYtiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZcvYtiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80DCC4CEC5;
	Thu, 10 Oct 2024 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728575517;
	bh=9IfOKTFMuHxxcYNIEM0Z3+cvEbDsgPRaUT941c6hTkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZcvYtiLt9Dk8SRVATcq/NJvXvSV8USShGL31Hay4BVv7GfD604Khjhe0i2UwuDRF
	 R8dV7Vr67vmVYKju8rq07oKik2a6hAlsii0h89CI2173qfIc1cgOR8S8ISIiMnjiYz
	 qus3SSvUiHje/OBpSdOl0Bxxc0b2yxYdRNsnJzMc+BRJdtXupwPur9Qal9tY/7W02N
	 KfvH2a8Xwg23OClXuluyvYsebSrjfTBBR3r9Hby5QXF4NalG7tR8GzgWtM9sdFng+a
	 9YzVXtRhI3AytH/miwerDyJpEBtwtiE033NUXAR+Czq+7MhDO7HjJk1PDTM5lQU689
	 +TWUYkju919Xw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux@treblig.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused color_fwrite_lines
Date: Thu, 10 Oct 2024 08:51:54 -0700
Message-ID: <172857548034.1133000.14066165819952517246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009003938.254936-1-linux@treblig.org>
References: <20241009003938.254936-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Oct 2024 01:39:38 +0100, linux@treblig.org wrote:
> color_fwrite_lines() was added by 2009's commit
> 8fc0321f1ad0 ("perf_counter tools: Add color terminal output support")
> 
> but has never been used.
> 
> Remove it.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
