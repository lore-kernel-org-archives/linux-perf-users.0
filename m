Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675C33B970
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882697; cv=none; b=KyshnIJI8dpBN5K1klSWTWLMkiyiOwacTq0y1fCj7QSeZvLO3zDW8mL4bILRUSl6iIL+NVJjpKAo9bRJ5TPVQz2FfKvo3of30oT+1WjiCQXt8XFJTJ/QDs4kl+4vRHraENMo7mNgIFfzrMLkI7Semh5VqUCa7jVS29p7w2Sq4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882697; c=relaxed/simple;
	bh=jtyHW6pkkhFGlMbSXvbXkIa/LL1rxwtyJnZtxdfffwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZNPBgF7UzDXKRA3fqnVHiZ5Ef4Xhurbdv1xkRBbwoLZBZGTDwKQEIYaSX4XrLqtk6dsWwIUX3m9mVotqOIGItf9oFnIAfKLjB81+xMqU+SAt4+xnKQx0M+V+j2o7cAZWnSjbIQneUo2NMEgxkgT9zjvQsD8eI/1CiI6M+yGsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFwV39pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFwV39pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6441F000FF;
	Sun, 20 Sep 2026 05:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882696;
	bh=jtyHW6pkkhFGlMbSXvbXkIa/LL1rxwtyJnZtxdfffwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFwV39pm+ts+GwiXGReHpCbe6baB1U0MHXzw7TzT1ELJbeGW+2KYOQd+E2GKZKpT+
	 zZfePa9meAwMQW9jkkvxe7S+TVB0bWxAu9Qww902E9ukjtICUtDFQ/p3fKrWc2C1Jd
	 oqa9shKssQrdpvmOWJHy9paaUdhzY22Jape/F8/Q6GpZ3Nqw/m8ShAwF1B9Hl+XUo4
	 0KmGNfXy9WuLodLnQBluYdWVw4FPKG+iISWDnE6n3yH2qnu1MXT2xEAsPqCv4miw3Y
	 EAtKi3D+epf9OT62iw5lmnKiRYfVFpUukU+ZuciEIkSRrPO6LnujcXmwG7RZ2qLFFh
	 YweUfCFyaB6eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 41/49] perf test: Migrate Intel PT virtual LBR test
 to Python API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a4cedfb86804468cac0b629ac4ea553ab494ce22.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <a4cedfb86804468cac0b629ac4ea553ab494ce22.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:38:15 +0000
Message-Id: <20260920053815.EF6441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Migrate the Intel PT virtual LBR test from generating an inline legacy
> perf script callback to using a standalone Python script
> (perf_brstack_max.py) with the brstack iterator API in the perf Python
> module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D41

