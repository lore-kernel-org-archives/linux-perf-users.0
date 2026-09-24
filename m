Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707641D216
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269585; cv=none; b=XdzzSTQ+wWCjvSlFI4TuNyGNhTK0PESTD7zQy3g7lcuP/gDAXtityv8XY7q1Inr3xLMyuIDZHl2uZmXVqk17LYOMRWnnk/SjNUl68OX7lGLaNZfpmLIyh0/jQ5B6TYH3RYAI4AKnOvc+owmQqLI6Px0XutCmC7xfcffrqhlixt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269585; c=relaxed/simple;
	bh=Z9kV6t07KVhwekjvbQwJuW8T8Ywik+mGgQr4busSKbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWGRcUfs1cLwjIpbexsvOflh/yA5JO3d4q3aIBTrzQa1GLd0f71LnUuM8MGej5XGYxwzM6HkrLxYayNeodXPLWegDYIP56G0aYJNd4aHXmkT58Jvpj3iMdKu3VkGQDu9stvEoS20/NU3xDCId5pxx2AM3/WygdjoYUAa5n5k+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQZ8KV86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQZ8KV86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3831F000FF;
	Thu, 24 Sep 2026 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269584;
	bh=DfqXfnO3b4yonoI5Bx8cqImkDgRFs3kHkVdCBGt9Nng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQZ8KV865OqwUNjVyYb1uN+d6tfEUr9aQluJ9appDDDGGLmYpb6AhAXz9x2AwS9+8
	 ozQuRc5ffy6HWTMvX5kFkEqUaXdU5Felw5Xxewd4uIfUmQAgyOqemtRe0AoyY1G/8u
	 SQmFoWFKcdCBh+QYo5mQgc8aHk7aQvNXgYjxrNJoRYamgSu6x8zU7PneO91q6Eifdh
	 YegSGKFrTXeXOt00rP2TZxmbpt4bWQ0UQUv+gg+XqPZRL8hoApm22EemmDte/IRmc0
	 2/XAJlkxoogSR7Rv5a2//no7oLQcXjGesjzKC/kigOp6iblWLja29b5PKUXY7BsAR4
	 S6dmrqejo2kSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/26] perf vendor events intel: Update novalake
 events from 1.00 to 1.04
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-16-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:06:23 +0000
Message-Id: <20260924170623.CD3831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/50afd00f84fb8c7bfa26a993a968982=
c1573e6d1
>   https://github.com/intel/perfmon/commit/b576c542b68d377fa00ef4674715ea8=
7a37c309c
>=20
> The format encoding for the off module response MSRs, introduced in
> this patch, is updated in:
> https://lore.kernel.org/linux-perf-users/20260923015517.2665398-1-dapeng1=
.mi@linux.intel.com/
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D15

