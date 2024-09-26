Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BC136337;
	Thu, 26 Sep 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371719; cv=none; b=TgpB0DG+cZ9ZhaeIZgTlerjyWCbCujs4FUQAcymgpRRpkDRNztM8cQ+nvRkG8LlsrLOmoJm3pvr0i5GNCVfxBOnEV6q6KVWxMuCBUrTkDz6MJbZy7+/BNOFS2D8S7cEDvNFADDHjkZc2R8fcfCM40jiKENEpCSkrRfClQVWY3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371719; c=relaxed/simple;
	bh=RB6wXNW34ocfWiFQfaQTQ6cK44GN7hI5qkA6lGloKJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGrIH24u1egohDfXw0YdB/ajIBfkbxgjTkmZRh19GCQWpOjTc7ZMFXDDSegDtteNeI4CGlfNEn4kevrxrH/s0IrnCldkIJPeFXehKjilq64zOfH2f7jqCaTyrl+7l7FRIXEHu4d0c1mtUPJ2jZbh163or1XDT1+SzmlXz+gq/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Wesd95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Wesd95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDCC4CEC5;
	Thu, 26 Sep 2024 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371718;
	bh=RB6wXNW34ocfWiFQfaQTQ6cK44GN7hI5qkA6lGloKJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6Wesd951+VQV4qomnnHJqMETUZGIgQeb1lH9PaUV0N/UqWkdf3Ssbfw5Q6ujGhgT
	 EZ7j35NEwI9paSOpQ3okYMi41yWQa5gBrBL8Y1ZbHKIcWK1QIlaSXERWWnF70uBK3u
	 pQKyOdQC3VbPoHukDMyQIwNz1NzhvZo9FDy57yTFvvYmpDTv9NIHZOMutRerpIxU9i
	 qo/Y7Yp45ODTXrbcRqk+U+0WzEXwpbHa/7oWRie6aT5R/VXv5+69jQfEtW44vHE0Rw
	 DBrWevaZLbf5ETqMbDWV8elHCAHYo7Nho8ofzYBtuYEdQQpOOsMYSf+NnF7Hk2gnrP
	 uUvHYaIXX/NUQ==
From: Namhyung Kim <namhyung@kernel.org>
To: john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	Xu Yang <xu.yang_2@nxp.com>
Cc: linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] perf vendor events arm64: imx95: add imx95_bandwidth_usage.lpddr4x metric
Date: Thu, 26 Sep 2024 10:28:36 -0700
Message-ID: <172737169961.3854870.1174109541576038989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240924030812.3211029-1-xu.yang_2@nxp.com>
References: <20240924030812.3211029-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Sep 2024 11:08:12 +0800, Xu Yang wrote:

> Except lpddr5, i.MX95 also support lpddr4x. This will add a metric for
> lpddr4x.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
