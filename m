Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553981;
	b=nXm38xp7b7dZHP4SeeC2ia1yPQro1eGUpw3ThBCCYOs9P3MH3v43CCOnuD4B5E7qGvv+
	 IIv353N73vd2KF9Fr/wfP7HPyLBXvVST5R7cZQl9sIqGdMikIn3cfqx7hJCKilyvnROep
	 hAanby+GuwWaAarIiacLZu5jmaFH2GsT3tMmZy/bgNxA04sDcihzbaRtQSwVj31pZ1Cba
	 6x2QlIh0Lt/+OSvUyar7XspJj6QuknDG9acZnCiuwzXx9ZHmMq8cLP8wp/C1Q1HBe2IC9
	 OR+9bnkihC85cO9wzVCOQATZK2u8USiTU9B4uXM3SlSahxacZqybO1UrXd1mA+YY5Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553981;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rBNRWVZvSSE8+Hj10INTxx4GSsQBeSMz/qbYv9M6JmM=;
	b=Z3+pCBXWQ8G7m48lv004T96o/SPjQ7q6fMEk7d+qXfTKCtefvqefPyqdL2btXEq0XJFx
	 5mOH96NqKbLT0Y3FeV7YnLBXXdmXxfUnCm0U0gmqUyidun2mHPHdaaR3bF34e0IVkdnij
	 hR7mlR+shEAka/e4SWdc9RoniSmecAygLxBjuIzLpSgFjoRzmeLQC9JwVD1Yk4mZJYN/Z
	 sVJ/+cdjq0lDcfpdLXUQwq4tVjpyuICy+mlYLlnIlhuu/fQXdbFrY6feqVuFSwaQcl4wd
	 LR4yltouGCO+cuoCXDszoCknmk+0WqFx26whMf1Dbxj9b9Nv9GHwRqoxrMWwLrt/MbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N9/uXGLz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD77606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9/uXGLz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4251F000D1;
	Tue, 24 Nov 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553981;
	bh=rBNRWVZvSSE8+Hj10INTxx4GSsQBeSMz/qbYv9M6JmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N9/uXGLzXVQHy+Tqc6pod1U3tThti/n1kFW14HgPq4Fh+At6i6DTYQa4P9JSfWvWH
	 7Vjz8gXjC1MOXUNwkqnocvq/s4plyIx6bOjNNTnGQATIEEWsnEkCerWCf5u0KSG4DA
	 08GkHp3G+7C7+3QKEHf5yh/E6XMZnlBOYLh/+wTPg5kzffWtd25sqr8TN/XEKiP0HW
	 gLAR5bDM5E1bSTa3CI68NGbMC9M2VohgRYykr/iivQqUh4yGDkP0bJf6alze3c2YRC
	 K+jvK/pUpanEEqM5vTmn5PWmt3KwpEMv+I7ORSzncJzgdy0TvO6WptbLV0wnVDBsmh
	 mzdKeDuVUYh9g==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>
In-Reply-To: <20261023101256.1752713-1-takano32@gmail.com>
References: <20261023101256.1752713-1-takano32@gmail.com>
Subject: Re: [PATCH v3] perf stat: Start tool events when enable_on_exec is
 used
Message-Id: <179555398071.1562760.17940327970242086300.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:59:40 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 23 Oct 2026 10:12:56 +0000, TAKANO Mitsuhiro wrote:
> When perf stat runs a workload, target__enable_on_exec() is true and the
> tool events are left to the kernel to start on exec.  Tool events are
> however emulated in perf (duration_time, user_time, system_time,
> num_cpus) and have nothing in the kernel to start them, so they stay
> disabled and are read as zero.
> 
> For duration_time this makes CPUs_utilized divide by zero, and plain
> "perf stat" prints "nan CPUs":
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


