Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCD1CCCBB;
	Tue,  2 Jul 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945878; cv=none; b=hXy75kExzds7jPRWrOY2QgFGLRPA22oheQty5V5ssCZu+TmaDmss52iB4eZNsBI8nBVTBarN+CkpBJa2XsLgjdHqTLx2sWBJHWPInqjyZlNVk8VlMozRBTg98mCSUb+F3jbjhAONfA3J7wZZPRqz13aYHkwqdJWE5HI+bmAbGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945878; c=relaxed/simple;
	bh=3hI3vPxNpTlTmprvlq0TgyatajdK0bix8UU13dkNtjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4hm6rYJEiLgOiGlK5TR3qzC31X+19/L5UZ0YLrz0ZFMcT1J1UjwfOiGYASc/u3wIIXY3QOH7fBkaCYLmB4zEm9VntJrWzMPhWDXSsY+71r/oNz8MWMjcXs3Ef+4J9lV3++Dq83IgHNUrqpddfRVR/FTw2ABbuiLUs6U+2Deavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf49Vo6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf49Vo6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E12C4AF0A;
	Tue,  2 Jul 2024 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945877;
	bh=3hI3vPxNpTlTmprvlq0TgyatajdK0bix8UU13dkNtjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hf49Vo6VQqu1UGsjEJfRzqV3RZEt9TvzqBF2ric8M7753PEclLBSMPLTdiIAEgdx5
	 Sj9xXqAEQ8eEVhXATx1xIZ1v4bmPx5KupHnN22PXaYlYRv+bngMS83I/dFq85fHIEX
	 hR+zxRVHrpjmpYGxScaXtRwt9Gqlrz6X63KL7kC9dnUyWPT+cQRKhWIc2DdnC3EE4+
	 z3RjnziUYn2i+AyxIlxGOb/Vtv5kEhGShoGv9m9sQbpKISJ7DHKGEvoeUQXlEnBFWm
	 Ud20cGOQ5o3MuSLqA/+pLSEwBghoMXhCcFal6nUldOVsvKh1VL+yNJD4Fh0VFFpuL5
	 AAwkyqLoLpkeA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	Yang Li <yang.lee@linux.alibaba.com>
Cc: mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] perf: pmus: Remove unneeded semicolon
Date: Tue,  2 Jul 2024 11:44:36 -0700
Message-ID: <171994586729.2906394.1629165213262512935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628053049.44521-1-yang.lee@linux.alibaba.com>
References: <20240628053049.44521-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 13:30:49 +0800, Yang Li wrote:

> ./tools/perf/util/pmu.c:1776:49-50: Unneeded semicolon
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
