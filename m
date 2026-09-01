Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAB361DA6;
	Tue,  1 Sep 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236090; cv=none; b=dETy73WTGPNxbzt4iqIpzzMkLB3XJMgbxD9Mz54KkG0QDSOWAB4hLJnQxnGNZNiOlRWmwybBCLLaholaquQ2QjL5Lc1KsW6bbo0/jEmd1YR4Fd2RAQJftC51ytCCxo2Rz54DAP34cprZirRVH/ahDkcbVX044VuknQrChKHRQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236090; c=relaxed/simple;
	bh=f75GyJe/DghJpOtSr4RTHlGaA9POd0XgivlT+YjAH+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=txcmnjI6IA1A3nmfrAgDEhuGVgoZ2sCuxzTH8ZmfNeRU2ninCXO2WBaKTHnSYNa1fKThHDmR0um5J12XpCCfarhLqP0c3gxszBqOt0Dekr/CYtUn/FBYraurSy+hXAX4sM8vA6pvP3HhdYq0Lwr+dXNy7LkcmktvqbMvnV1ubHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLtW/noU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLtW/noU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5801F00A3F;
	Tue,  1 Sep 2026 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788236088;
	bh=Tatq90mRgGXzoFIHHINzBAsU7Dby6s22scNlyo6u8yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MLtW/noUnkwvbRo6IlJoAQNxtDBLz8/R3dJmXCJgzP+tRo4Ye7jR7+C6R2kK8DARq
	 CM8LRepAoTtHz+MmmR9x6Hgh4MJfaLkbJalvI8RSetN22MNp5UFw0y8gXomA2UKaBY
	 LOIjGb364u/E7OaRaU3h4ZEaFolZDVL7/Rk/QE4BC66NO/Vzt/MPxnuaXpDRpeXGeN
	 8yNjaSTc/JQhxpDKpnfRDYexqfWPzIVddeOvS7r7xxLbXdat6i7p/bGlJbXvwADjc8
	 Nk9oS/RQn8VAplye2SKFMsI3hqLIgR6+lAhJJ12lIzdV9ZOA1X7i8A1u7JN4e4Buei
	 TJP2svW7vu32g==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Wang Yan <wangyan01@kylinos.cn>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, atrajeev@linux.ibm.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260825094733.1031566-1-wangyan01@kylinos.cn>
References: <20260825094733.1031566-1-wangyan01@kylinos.cn>
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples
Message-Id: <178823608854.2655665.1683265655363972477.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 21:14:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Aug 2026 17:47:33 +0800, Wang Yan wrote:
> In powerpc_vpadtl_sample(), raw_data of the synthetic sample points to a
> struct powerpc_vpadtl_entry (48 bytes), but raw_size is set to
> sizeof(record).  record is a struct powerpc_vpadtl_entry pointer, so
> sizeof(record) is the size of the pointer (8 bytes on 64-bit) rather
> than the size of the record itself.
> 
> As a result, consumers that bound their access to raw_data by raw_size
> only see or copy the first 8 bytes of each DTL entry instead of the full
> record.
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


