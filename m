Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013C1BC20
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253185; cv=none; b=JyDU8rSI2Nur5BOTYcCpsfbSOI1DI7lIXERz5PXSzig0KNBUumgvm0ae75gYJu6mi5S1aW1V1XPR1S7IKBxa848uHGtruKu+DCF917t34NdXn9bwqjR+UzueBMEn5ByygGHTeZfWZq3Yumue6iZNiZgP381HbND9tQoG/jTa5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253185; c=relaxed/simple;
	bh=ZwkOqNYlxYx2ROZjI6aEXfhXktUM4H16pbtLQQ1r4qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeEcXukTOH1VhauyBi53So635RaJVTDP9MqR9M9p3PPBnYebhfypCKbpUr3ZsOzYb6M2uqQcOdkdpYYbM3uBUYqLu95bUEKARm5PqQcQaq+8l2CX6fwiruELZk+wvhQ5YzHbYewAJUa/5i62GUIIPsf6PnKgxCAuAzBp/B355Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqswiOp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqswiOp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C7CC433F1;
	Tue,  6 Feb 2024 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707253184;
	bh=ZwkOqNYlxYx2ROZjI6aEXfhXktUM4H16pbtLQQ1r4qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqswiOp92+ueqbOZB/1JVuSczU4VL4FoQQ3ZcFnvAa8HxR3oe3IAdXJ5e/zEFL0kz
	 tvLD6/rXLg4Lr5vX7XBEeeb/zqbx8dwzJ3wkgVAn75Rci42JuQdcekUtVJ5EAKjXoc
	 UMvCRSPfzXSlphpIqOnFQcjhjDXohgJQTKtvfjJiLgxrrk2z9teRgkCjYW0PHPw83c
	 kTtEaSj4aH7jTJ3A/vLtNjqQtRHFF/UOjHtS5xz5L5WAcwG75+qVp/tuaCCR3dER+X
	 4uYdV//J/yixoHqfG7UM9+I9gn2C3FSz7XxcATPZRtNmZe/4hD2iWXRDIF6bC28Er0
	 /PxQ5eX4C15vA==
From: Namhyung Kim <namhyung@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	acme@kernel.org,
	jolsa@kernel.org,
	irogers@google.com
Cc: disgoel@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.vnet.ibm.com,
	linux-perf-users@vger.kernel.org,
	kjain@linux.ibm.com
Subject: Re: [PATCH] perf/pmu-events/powerpc: Update json mapfile with Power11 PVR
Date: Tue,  6 Feb 2024 12:59:41 -0800
Message-ID: <170725313989.2448546.10195649247614076762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240129120855.551529-1-maddy@linux.ibm.com>
References: <20240129120855.551529-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 17:38:55 +0530, Madhavan Srinivasan wrote:
> Update the Power11 PVR to json mapfile to enable
> json events. Power11 is PowerISA v3.1 compliant
> and support Power10 events.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
