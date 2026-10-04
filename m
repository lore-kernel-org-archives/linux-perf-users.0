Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8753F4118
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094300; cv=none; b=GjEuGmSdxP7OiBfQEa8o7jfbfaH7W9GNVS+E+cz0N/+H30aaY+PDgYH6J5Kx/gXYjXbvRhjpfe1c/oh3bnfhkd/vW9P4mFE0LAoVJoBpAbBHqaDyhvDiW5mxsBhKOlLHaxzFmDqtqJzDFh3zodZ3/toXMFTIelYa/l9gjBAJhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094300; c=relaxed/simple;
	bh=ZNPIG1aQqgLcE74XgcfM6bYhO2YZAis/5mRUNMXHz9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYS1F2wZZMMOipm2uwmIvn2n83k1Qol8rJgS+KoaprjRMeKrpuK/rq2MFTQWnQdYdOh8F8HKgyYS6j1WIEdP1vZo9AdgOD2eKQcETVUpYmqfza3aClNKGOnZfuWWWirF3lRv9gzIxO0Hga/tJC2qUBTxLFod1HHnUW4qFj+dEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5YTqo6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5YTqo6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ABE1F00893;
	Sun,  4 Oct 2026 06:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094299;
	bh=Eg1yyrHukHGzHIoiHRFkX0kb9sRl4omG201jTwL3e5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5YTqo6EgdW+AvYNLPiWUzAIa0pTGpW1sRKJh8pI+UaB1l45Optdi5Sl9ofS2OTY0
	 25Txork8adQ5+0sbbDU/g838rAvOzauWrEdOlXM/02oe3N+pFONwAxVPLTNqDKIOSj
	 S0wrif1SKGHK2JPzMeurrq0+R8zAShEaR8pmuHyXaOhfMMn5NU7qUBxaXEuaBNOGeQ
	 2Hl/hHRTagVYX4LOYri39tnfHVQER1ll8l7In090lAw6yYMrTo8Io2FkGw67BOJ3qZ
	 Ou3/8fri0WOkYIYD7FjE/DpRJO6Z6OBOKtM9by7K0GGU1sig1b8tXUzfodWTWMqUB6
	 XvLv10HVAdlXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/9] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-3-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:11:37 +0000
Message-Id: <20261004061138.43ABE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D2

