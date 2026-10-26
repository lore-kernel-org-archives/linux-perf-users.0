Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052316;
	b=Sze1XyCzojIyzbXruRGSvVEkVxaXU9hB7Zexc5g6LpfTdn7s8d+7EGMIMSwfNZDd5I1q
	 IEhhuAf4lJg4SziMNDgtqiiDw4B5Xijv5zye/8FaUJPY01KeuKbRgnp6CIPmIeAnHDowI
	 a8XoOucYzVY2qP8VTCHr5N982PqonfM7eJqI16XhD/ByapCyDLehToJnmW7Oks9xwLcxM
	 H42h1+55GTv2TkpeI6id06DtQ54qdhTIjfErV8IApzjfJtHz0qa9WGW3gV9WIOeUY1LMy
	 79/QhDYfZ6OEjKyYin100G2vVEAP94NIYdeSgljQAk00zqHGVp5i1UZjejGzJOdP22g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=14N3scEcv3N5JxoIfImvwoCo08AW5NTfgN4DwzsA8jI=;
	b=iPxuqrMjNq+XvXC3o17GOeW/ZngTyBliRM/ZFMF6H7Dn+hldGdEDDOMMm/YfMqgIEq46
	 tV1yzDoFOinlQd6cW9rSy6E85aZel8rpR6kUhrQ0KXzh5US9wHXIm5ih7VXDjBUYj4Clw
	 6xMPxh3BetzdXKjXpEWB4mrv316yBvhJR7f1WWIdJxEW8fQ4m+oXH+H4giJLsGd04iPgG
	 9nd4FWuuMD447T7LsovWyPzizZzaCtfzpHxD3gEkeiOv2CqRZfeK/8Xd0XKHY/kvO21Wy
	 Qqbc/I19tA6K2+MKI6fH9L7o8wbxca3ocKDAae7a3qGSnqMVpDPLNOyWQBtug1VEVyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuANxUhw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDB606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuANxUhw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8881D1F01825;
	Mon, 26 Oct 2026 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052315;
	bh=14N3scEcv3N5JxoIfImvwoCo08AW5NTfgN4DwzsA8jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuANxUhwIS1/+yE3mDT2pB5XrGXOHDqHxSR1/xAx70C5Ug4v7qARha1LK3ZNPkh8X
	 vXwlw3bj8zFTXuXnqWaGRWUKsLuyNp39bHD0LgzUuvmyvsmLipYB4Z1Icb/Q2tPjRA
	 V7XWrdOO0MgJoZfMvRVLzSxWJAhLUMuP6BZMmIIxk6tWSn/LBUvPJB8VsCO8NWjmQ+
	 p8JVtx5XYp32LUCAxWOLbRxS8AGQHpFIJFCLlBNta6JhiOMDch9X+ELk56qq5FTykL
	 tjw45qnPsgv+d+6WI47B0+HBThzM0T1L2Qh/u81s4qFSCMHU/8BJWCDoq4rE6vUB8Y
	 1HkdLNpAby4BQ==
Message-ID: <sashiko-outbox-185779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/10] uaccess: Refuse and warn on
 __copy_from_user_inatomic() without an mm
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-9-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-9-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:05:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __copy_from_user_inatomic() never called should_fail_usercopy(), so the
> NULL current->mm check added to uaccess_should_fail() does not cover it.
> It is used e.g. by KVM's kvm_read_guest_atomic(), by several
> architectures' perf callchain and stack trace code, and by the generic
> copy_from_user_inatomic_nontemporal().
>=20
> Split the NULL mm check out of uaccess_should_fail() into
> uaccess_without_mm(), and use it in __copy_from_user_inatomic() to warn
> and refuse the copy.
>=20
> Don't use uaccess_should_fail() there, as that would also start injecting
> failures into __copy_from_user_inatomic(), which some callers don't
> expect to fail in practice, e.g. __wp_page_copy_user() warns if the copy
> fails twice.
>=20
> copy_from_user_nofault() already fails quietly when current->mm is NULL,
> and the generic user stack unwinding entry points (perf_callchain(),
> get_perf_callchain() and stack_trace_save_user()) only unwind the user
> stack of a user task with an mm, so neither is affected.
>=20
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D8

