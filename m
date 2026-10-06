Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17C49CF2A
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299267; cv=none; b=pPJRFjoefd6keZu9IwJ1BRki5sfmmbMbL0A+d3W0X3+C6KlXB75YAB8NUiHOHgmO+ha8x/pmxhgZDIkcbCIg7/MyyNiljU+4xA48O/dnlzl66iekiCUIi81qOlnILo1wkHAIw0XNhNWzU1zVRvUFgb3ingoOp5GiUuCdd6gNhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299267; c=relaxed/simple;
	bh=fFQEklJk3n6UcDqXn3unaEgMuwu32viwiiWvDQ6++8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KRSKForJ320seuER8Z8HI2yqnolNuv/RBgo4a+CBGzoDTHuUee0vlyXqWZK+yVNe/rNGIkvXejWp7GkZ2buRPhf5RKYlWlNCnetZcF1roQ0PgunkE4/WsJUB5WeKJ4PlfuIIzCDGImLGIWAF9I2JfJioRqcQBtP+PTK7cf6lfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMxQCNQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMxQCNQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DCB1F0089B;
	Tue,  6 Oct 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299266;
	bh=QGfFgr83vzgQSB/q1xhPKbrbxRXKZ6OVwJKe6/zgTEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMxQCNQX1DI1XNPhblcV36wfX6XqpnChTEXBlGE0+xm2HAc2pgWYkJF91G7H6pWru
	 6q0p96t29BeV4mE+u0LOEB5aGbGq7RGZCpUtFYSvSit2HrDWX+8ON3fJuanuTkiB0Y
	 ue/FFzEvz1ZCzgqcHmfxtk5YlmXE2cqUQMcudUmmDZIzT+TkWtS+l5dT3c7Af8T2fV
	 nFUjxrYU3QrkpP/zW8uDyxnl4S7vTumEdnLu+6wFIT5X+Yh3M887IvcY7zD8k2VEk+
	 r+sMyzGSHEuzoUag0qJQAHQmlZe6SVHJ0XFFyc+NjJ9VsEMk8lGySmnp3fqnYOyaH0
	 0p4mRYFLfCZJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf config: Serialize config file access with a
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-6-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:07:46 +0000
Message-Id: <20261006150746.84DCB1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Config file access shares the static parser state and, since
> perf_config__set_variable() became an entry point for background
> features, can run on more than one thread: a feature writing the
> config while perf top's display thread reads it.  Serialize parsing
> and rewriting with config_mutex and the whole read-modify-write of
> perf_config__set_variable() with config_update_mutex; config_set_mutex
> comes before it, as building the set parses the config files.
>=20
> perf has its own mutex type, util/mutex.h; the file scope mutexes
> here use the DEFINE_MUTEX() static initializer added in the previous
> patch.  The two lazy inits that system_path() and home_perfconfig()
> do would leak all but one of the strings racing on two threads, so
> they move to DO_ONCE(), added in the previous patch as well.
> bad_config() runs on the dispatching thread, outside config_mutex, so
> it stops reading config_file_name, which the parsing thread owns.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D5

