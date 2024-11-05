Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CB1DC075;
	Tue,  5 Nov 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824901; cv=none; b=jn39vqmjMw0yb74jIUEVjxNLUyICt69MHqHZJWYMAgDhI3K7xnr4o8ISgqGAvZ5GjHDKoCxkPR4MxqfqrKDqcjq+sbE8N3cCJFp+YWwPg5aSyAeyXr72z6hTMM/j+i4sj/JPYce4OSw9n6F1bKFwOAntWh7vz2F6YDJ6ezLpd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824901; c=relaxed/simple;
	bh=75ssd3UUB0N2VS8QeO6/PZRZc4Ti/4WoNRn31qFMKrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y12qyzfY7vlMh5ghx8nePWKB1KRK/9maQ+JxwPD8G//Awinc4OpNbfuzOLI9suDm6EVY7pV12TKnK+rNFKEcSexolP6nkUMNOb74EpdifLC4cuKBAAX9xK1k06JyRr2e+coQX0p1p9Y0FwWITemUy5WBxezTo6Av9NU9vKssSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUJNoeUp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUJNoeUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D2C4CECF;
	Tue,  5 Nov 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824901;
	bh=75ssd3UUB0N2VS8QeO6/PZRZc4Ti/4WoNRn31qFMKrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EUJNoeUpbrrLMVxUxzu3z5KZNG/TbnafSxnetU8wwdwMBZvHWXNeGyyDW2HyGl8tu
	 s7j4WC0kYACX2n6ZwP/ffdEptwogmKUXgYrdwbBA0O3R9sRc+7PaAMpJMJQ88FMrzK
	 p/CJux7VnSYLG0m+NziGX3NmOM9pl8s9rUQ0bKrBW3uNWJoMtnezJumYrGdhp8fVb0
	 /l0yWggBuoepE1O/tJCLUzIu/KpmhgQg/4Im1RLO4+8R2ZGC6aEedNblXW0JhzmXjj
	 Agnmsra+hdbIE+SUr/OCIiD+wzVRRAAcPD5cOp1xXf5Yqi9i1OpkJ8NiGXPHO/Y9Bh
	 728rdVZz5FFDQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, 
 Weilin Wang <weilin.wang@intel.com>, Ze Gao <zegao2021@gmail.com>, 
 zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <ZyjbksKYnV22zmz-@x1>
References: <ZyjbksKYnV22zmz-@x1>
Subject: Re: [PATCH 1/1] perf tests: Remove dangling CFLAGS for removed
 attr.o object
Message-Id: <173082490129.149345.12072597067529723354.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 04 Nov 2024 11:34:58 -0300, Arnaldo Carvalho de Melo wrote:

> Since the C test wrapper for attr.py was removed we don't have an attr.o
> object for that CFLAGS_attr.o to apply for, remove it.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

