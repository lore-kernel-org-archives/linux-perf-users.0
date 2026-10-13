Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5D4FECC6
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899079; cv=none; b=qsbEJoDcn3O9XpPJWVihNpnad3S7pYBnDDRdhsm/AlCrBWbJU8GlfAMmA9ETkNlujROOMivApUjvbNFKmT1G835mznlCR/mVFiVX//DFfeuZuJ/8lvfH36xSKHbJPPqx4nSsAWzZtN7PW3PxxPqAy2XlYx9Ug80YFWa1qEDMFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899079; c=relaxed/simple;
	bh=/uSWDjsubrlaBSo/sBjRLPel9r4p3zHdPu5NZQrVlic=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dM7LAsq2LUH9EsvnBc5VSQlAKSNS+cBCKMUm5C3MM54J7XBsKG9pwFjd6vq68qKeNIpMe+0h58WyfvBzwPaV6cEA0wYj+ciGrSUSClJEAx5k1XFVzThUuoEKXy75skeqTc0bzwTr75JV2clcpPAmmAb8YTTiIyy/zvTMpwf5jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBx5wkyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBx5wkyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B63D1F000FF;
	Tue, 13 Oct 2026 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899078;
	bh=RYQOeojN3flxTjNY7bQdMy7aJxjISvQ2qzQmyAu5rCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBx5wkyqQUtnFvI34LBPVG8jkNYsV+xyxB8aV9Yu+QGs2R/KeX2GNDyfCmvkFc49v
	 I5hJQzylkPOQXzhvzAhJz3ERDmXuy8Tk5hWuQ6uaGOU7Gmbid77NJSPAc4pb2YDFV0
	 +1rTeVbUl8tyIIg/7BYN1JMQm/iK2a+eH9YMBj+Gw3qjINgMz2SBSSJ3xVg7+rYN0F
	 5NJFRYMk1x+ShqIhtWvLL3pQxi7qi3Xw7QskA5oxg4bkVVB95y/QBax2t978Tj4m+y
	 hcWn9cIKfJsLxQeOAtuCPSb/nWmhTgRcSqggrDakSu5lEWm0r1fpgL9LidVr3dK2kp
	 nfpiVJbP4g9yw==
Message-ID: <sashiko-outbox-169852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/15] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5ae906f3643fec68139e6b94e43c6687a784e41b.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <5ae906f3643fec68139e6b94e43c6687a784e41b.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:44:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to track data types stored on the
> stack.
>=20
> The implementation handles:
> 1. Stack Loads: Identify when a register is loaded from a stack
>    slot and update the register's type state based on the tracked
>    stack content or compound member types.
> 2. Stack Stores: Update or create new stack state entries when
>    a tracked register type is stored to the stack.
>=20
> Similar to loads, stores also support saving one or two registers
> (in the case of 'stp'). Therefore, propagate_store_reg_state() is
> introduced.
>=20
> With these changes, the instruction tracker can now follow data types
> as they move between registers and memory, specifically for function
> local variables and compiler-spilled values on arm64.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D10

