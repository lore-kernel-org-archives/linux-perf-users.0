Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7514AA9;
	Thu,  4 Jul 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123220; cv=none; b=Rn8a42BTJwAVueuQpeDeaX5VdFoGLP5QOsge/IQCeBJuX5XY3s0vGmxeIGgE9Z5e+R5JqeSw8RVJFXh2dT20hVXgAy0GigiFh4D4EgiU447m0MNw5E35qJYsE7JWRofpTLPWUwHols3NW9IHljAvWrnXtKRlG04iBiodLLgePkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123220; c=relaxed/simple;
	bh=i+a5T4u17XGvIRqCem7WK9rOvl8Hp+2kjFnKPeJnCXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf2UydgCkaRfRGtb6Q1GEtbUlGiqpnrw9plXKvijgTZrGRrkXqCMod9EmvyNRs2w6UuqK3ypKanX0xkgjnAEq20egMCo7BPq4/nylz4Wo4CjVvu990LqaRPvd05Q5PEl/TjjU37vdJ3Uv7kh3UFi04ci3v+gx9ReR7HgH8e7pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRwgXIyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRwgXIyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B2AC3277B;
	Thu,  4 Jul 2024 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123220;
	bh=i+a5T4u17XGvIRqCem7WK9rOvl8Hp+2kjFnKPeJnCXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRwgXIyTHKr92Rg5OTo13BpgqqAJTOOh0qQdfuFymj0Fk9x3qTn8LlG0efYp/R/pT
	 v/bo7iRtuCRg7gU8yk1wdgUVeeRYxwrd3gjZ3qd+s8iZRj4tynPxTzZL7xnXbheGEq
	 U3E33u3Km2ROB5hmg7DjDd7pkpIcA08tv3zht3vFvDpRQh83ZZxe2Aah1YnY4tQPl+
	 jGh9CZ5w0WGxILSgLwdgnGJpppBMlFAk3RMiMiq/7Eh1Qk0JkzTRGxG5AfqZn4/0E1
	 txIgisImoXRFbNs4eFYHQYMNPDnmYxzqVYhnYZSLIVzz6QXgRNKi4JgEob8Op9nLPG
	 m8IOrySV1+xuw==
From: Namhyung Kim <namhyung@kernel.org>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	irogers@google.com,
	Xu Yang <xu.yang_2@nxp.com>
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v12 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Thu,  4 Jul 2024 13:00:16 -0700
Message-ID: <172012306277.184170.12018563505665201113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 16:03:51 +0800, Xu Yang wrote:

> i.MX95 has a DDR pmu. This will add a compatible for it.
> 
> 

Applied patch 7 and 8 to perf-tools-next, thanks!

Best regards,
Namhyung
