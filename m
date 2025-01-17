Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C1A2860;
	Fri, 17 Jan 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136490; cv=none; b=axiU049r0jqpHE+HgRre5MGMlVfd/GM6GzBNhf0EtEvvXSMwZtqsYoPaT0uxq/sGxTrHGaLaJ7ATW4mYaUFiXPWuhGp7B84Xsz2HUO3d3rkAR7k+t0tx0cgt4/3LzaW9IOrmfpzZJDyHB903DZj5y0cTe+4PgBMUvcf4eeVLzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136490; c=relaxed/simple;
	bh=1ObmMd1uEm6P+sRT2Anmzwz8DMM6q+89TQ+O6LSSsdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q7v/juG9ljQB2b6U3HD8MBva6qDtQNCMuPnHfWeSKKGbuzcTJ8t7DtTr0LBy9HPyQpwJAr+AriRhPWwD2LXoirjoo5C+gkUufrFADqAw37h6vY8wCqUDuDigyH5yJ9mt9agW+fG55v0xxia1msrk9nWrDbjOLhkqEYS9T+3RNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU0qsmWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU0qsmWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DDDC4CEDD;
	Fri, 17 Jan 2025 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136490;
	bh=1ObmMd1uEm6P+sRT2Anmzwz8DMM6q+89TQ+O6LSSsdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uU0qsmWyGmypT+bKGYR6TBIRZVQYL7zNkCH5xr7phbjpTEfrPQBR+6OUlB3AJOfGm
	 B9jLJ/qSd9WzuuHPa+Vt8qJ1VmW9cDOQ5/yWx5mr6BCWA+n7pgYWhr/QF2fzqXGUTR
	 8EXoh8gjksYSJry1rXb/cI9s/c19d+ZWqkF4j2OR9H3wJei6lNfZU5mU95w16rrkyh
	 ZSZCOJS40q2MJrJf+YZXK8ENi844dU7+rPT+4grcHwMlAiD4r6sLdNhIOuEBqssq56
	 4WdoOspGgUfinSHL0zzPFwzSfGLQTAolgx22daE+vo2CZ03P89eLSwabxYLQLq1Vgl
	 07s9nREcY6nxw==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250108065949.235718-1-dvyukov@google.com>
References: <20250108065949.235718-1-dvyukov@google.com>
Subject: Re: [PATCH] perf hist: Fix width calculation in hpp__fmt()
Message-Id: <173713649019.2190713.10145326367169451333.b4-ty@kernel.org>
Date: Fri, 17 Jan 2025 09:54:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jan 2025 07:59:34 +0100, Dmitry Vyukov wrote:

> hpp__width_fn() round up width to length of the field name,
> hpp__fmt() should do it too. Otherwise, the numbers may
> end up unaligned if the field name is long.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

