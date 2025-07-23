Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477825776;
	Wed, 23 Jul 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286621; cv=none; b=YdF4rcxFJVOMZvnu1tFoX9vLtNrbLvuFers7h+EcgFfdS4cBbD1yz78wUr3i96NAq+MhxcKTXTLX7+80o7p1gZmK9IFBD7NLGSDqzW8DwF77uGzq70eMCCjta8zYGlbf22QCsJCR+SGu/ji7M2OOfMNyRPi0TGhcWW/t6tloIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286621; c=relaxed/simple;
	bh=FZ9wivqmwRBlfq4CK8MqFw5NJFQTIcmu3nm4tm3DyqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/XlRjawTamae2lj4m5v3Xp2SZI1hV96rkRA6ybXk5YsysYy1i6hDJNDv8Usp8Hi4khn/l4sMfSPfxHY7F3XCZU4MEOuj3vqOVGnUzXqZmomvISM74AK4CO0MUV5HfLZ+1w7plJbPxDOascA64se/xTmun8y1SKM/YQeCrRkpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFB9C4CEE7;
	Wed, 23 Jul 2025 16:03:36 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-trace-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/8] arm64: Enable UPROBES with GCS
Date: Wed, 23 Jul 2025 17:03:34 +0100
Message-Id: <175328660445.3870926.2919716092405832672.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250719043740.4548-1-jeremy.linton@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 23:37:32 -0500, Jeremy Linton wrote:
> Currently uprobes and the Arm Guarded Control Stack (GCS) feature are
> exclusive of each other. This restriction needs to be lifted in order
> to utilize GCS for generic Linux distro images where the expectation
> is that core debugging features like uprobes work.
> 
> This series adds some user accessors to read/push/pop the userspace
> shadow stack. It then utilizes those functions in the uprobe paths as
> needed to synchronize GCS with the changes in control flow at probe
> locations.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/8] arm64/gcs: task_gcs_el0_enable() should use passed task
      https://git.kernel.org/arm64/c/cbbcfb94c55c

-- 
Catalin

