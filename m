Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD2199D8
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862554; cv=none; b=fw6ipNJ7nCgX5E3gGkI6DcF/DWRSTsgSIADLlvchU4rJTVZCIJU3PiQ1k/hHn4MYD4CcGlzisyPCFWt/EKEXdUHSn3JQgCX1XjLttHrRyvvjXo7bD02QhIRWtQcySGW18UrYj18w3abZvFQpGrf0dYeB+mOCsz6+LILqf8Sp9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862554; c=relaxed/simple;
	bh=+RcttCP5LLdz0YMdk/925O55vfppEpIEmJz7z7zcCY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uhr1NOlm1LjHkiOOS30Ral3VYmW85tgfQOWQeYbNVoO3Pvm+p0YZgO2kC/E8/rvEoNduSA94vdMj7arc/kk4IbkapNREzC/Y33OY9GFgjhuu026Y9tBHCr8QqeqSPSTLGCrXYVclo7r0zLwlFaaIfoojIDcpME6wD+da42Iv7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+W++TEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+W++TEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439851F000E9;
	Tue, 30 Jun 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862553;
	bh=t/dDGecgQnyHBRD1CloI8qbKKQ9H/fQiDD0u9Ytdf0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=P+W++TEYtBN0he+DRSsSh/pTdqhJpG/c4TEMUMlz4dsYxFz09eNlg8LJqkotJVUDp
	 VGP82pXyncBdOix2vcU8VXZ8JJajsF6QPfufBWcd8BB4lt3+xaUmtEdwljLtaW0RJW
	 eik3Gn99oW4kf8RJOp2ZVQrpfnThI/MjfAkRVium4nrLAO8LTij2qfG/WZQ0qNOYJy
	 ajmEsss41G/Vesr3b5QFj+Ux2PNQSe7rk4SjaI6V7GHVZSxCDwwpkSxMbxel89ntT8
	 j947RQBCigXW0BIGXxPIFYIGI4+TVDY3oSKBUtdbYj2RCAEml+N+dpiwUzGh6KRZZI
	 HJQcO7uTac6xw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
 shivani@linux.ibm.com, venkat88@linux.ibm.com
In-Reply-To: <20260607140245.95706-1-atrajeev@linux.ibm.com>
References: <20260607140245.95706-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH V2] tools/perf/sched: Update process names of processes
 in zombie state for both -s and -S options
Message-Id: <178286255323.2863034.7654707778135452027.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 07 Jun 2026 19:32:45 +0530, Athira Rajeev wrote:
> In redhat perftool testsuite, observed fail for this test:
>     -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)
> 
> This led to analysis of "perf sched timehist" summary options.
> 
>   # perf sched record -a -o ./perf.data -- sleep 0.1
>    This will record using perf sched record
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


