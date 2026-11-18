Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039436;
	b=f1eY0gi3xiJZPCNzHgW9WzDCDdZgz+gRoi3jY01JZTkF+K76qYA5aUb3FpG7rhGQo+WL
	 NzPZdYrFRRLiVCW0yGaTsNOizg6GZv+xUVHKeMtx+f//IG7wiwrZ42SiKMjKKAGTlGQhf
	 Y8Gk8QebJliWi//3XY6e1Di5AZS4N+5h6xFSiEf+C4Xo4uhWdVVnO89OmsnSK5IGB1sFL
	 Ts5Rz1MHbRnm6m9+cckZanBszcF0lw79R9I18wbjtvOOs3v0/oQwdkO4Go2Hxdad1LtfI
	 4u0MISfCXfXLzy+ylCIgvdwSAOUuXXUqToH0rimNdICPA0zJUFvPvG4iX7YEV9I7ZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cq9jxYaUl5NAwsM5yUFHwobeDkYnOErP0uIuVk8gr/g=;
	b=tzF5+wHUR8OHXTKJfgfHrZXw0ti9VrtrKO6dyoLJpvhsHw8dxonvqRuWux4h9m6NOQgT
	 Uozg4yaMT2aLH45CBG5kf07C1aYxlC1xKcfdGnMvX7QtwDjHgT01p4ThjHXnrwTIOv9wr
	 xNXQK2/12b0UMtyszrGJF701C6/KKvVVc39F5FXXGHrUR8wDuoSUS8PnHw1S5qeGgX4TA
	 1l8CQN0tTaaJ3juAk2nR4NlQsFXwLtnTCRcqBTEhreS+1ZobEjYilpo+nVStqXhzCQ+3P
	 BgELisAaWLAepp7OKcRc8ARIr95O2VM1RKzYCE4SHN6BU7z2EpUGCj3IowQ6OvmHmqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFGN71P9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD70606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFGN71P9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B17F1F000C4;
	Wed, 18 Nov 2026 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039435;
	bh=cq9jxYaUl5NAwsM5yUFHwobeDkYnOErP0uIuVk8gr/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BFGN71P9uF3STmuDHj42PNW1zjQnDa7ggfkJMeC/oy5uBXJdnAxvimG+uYFtCvDUW
	 46RIrgfEtUkRvBF0FfLUfhcIz98OJqQvslPKxRzofI9k8Q0DvgWnO1zDZCnNqMcmyU
	 mwvxsf8JckFQv1DqZZv+K9B6i05zMNL7eZJe6T+wNK/83Otx55ihczJN5yIes9uICa
	 bJItEfrqzwX9DeQ0ub6AVA+ySjjxBHBY5obsFtapActLWA0CyWU8GTh+MtHGXS17g9
	 zadIPuGoDmu8JdH9/ZsLRQWq+JP3T/T8GaCPUcO1XXxStXdg8TqhZz+JD+roUzDD54
	 CWXvQlN+rRSMg==
Message-ID: <sashiko-outbox-222071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/13] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-8-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:03:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register (with DWARF describing it with
> a register location on register-argument ABIs), while the unoptimized
> workloads the data type tests profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that takes the pointer from
> a volatile global, so the compiler cannot constant-propagate the object
> address, and check that its three member accesses are resolved from that
> register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D7

