Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146847;
	b=j1OGW03/tKAqwBD8spRvdZjpwohhRHECWcGBqE3Cl1VD+8hEygLyiJdqXzHx6LJ5HQSo
	 A3CbysR10UTC3/iFhOB89kFTrYXf+bR3s7OMeLl5W67qsxKU9vqHVPvsI88Dr8JDQU6Og
	 1mq6Pgrpjh4bQLnHkPZh9Wj8WAT5BoJ2BnYk21f+pexhKZPBvv+i+er3XjB0FwAw8CzAi
	 d8ISt2cvkWEdXpMVEh9zeSOX3fIAEDc6ukdoK+5jxCH6pD6EczXz/Y/jLzL9xPzAN5roD
	 4YSyCTpPDF9nye0vZyIgl44xU59lcQ/cG+/bYoaetgbXNckmr+e2HEY9PsX54enzH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146847;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=vx2RVakFc4KTJ1Kk8FcyhPosuohPC/dfT87lf+lS0d8=;
	b=j+yFGBx+IYGa8cUNhDPK8mOlPROghW4G0e5AwZhDscqkYCdy9s/qb5T2nNmA4ZB0NaYp
	 M/Bvhe9CPakSdTVQxrlkSirz/AlR6ocOQ3pe+WlPRcOg0GwmxHgMPZqNAIOi7uKLkg0k6
	 4h06czVs9kiv+U27UpqWew+DJwLn90YwjBWvd5K4F6bnBGmxfyIWNTJ3rVAhOf4qrkK6T
	 5nMuCslisLUQ3Og1hg6EuYaE4ZnIkvIuw0ZtG/9x32VIOyhJCitI2/lE9PRAaiMvSv+Ax
	 zY7zaHcqXHXA7PpLJvLjeY9lIUfxN4sQ3vVxntKVyGakGXTyWcFvr1DQDboFG4enPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ak+KneHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8A60A2627;
	Fri, 20 Nov 2026 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ak+KneHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E7E1F000C4;
	Fri, 20 Nov 2026 03:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146847;
	bh=vx2RVakFc4KTJ1Kk8FcyhPosuohPC/dfT87lf+lS0d8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ak+KneHmfaZXeYUBqu23a+aM5FxG7gJNAIb0NLyPcKmUBZvxXPXvQCDAxZEsmTFEb
	 1mjtrY4xd7UBIHryLJMtdOa51doKT3y6fl9UaRcQeU/sVJFofEw1wQXdohGKo84e/F
	 fWcD9zn+t1XVBZxbkb2bUP/PmDhhmNF/TsMfbTRZbuX0e32h1GW5cp5du+7Q0mevuJ
	 vQtFsgPJe5K+/ZylejTIPPC8JO/TXF7QZe46YuoiREyJ+1U/UJpLoWyqnAGnzbP9Ub
	 eoJGSn5L9ed1DoJLdZhnvTHfa5Hb/vh4M8vJepnv8kVQUa5Ec5rL95Kxbuk2NBoBfa
	 BvVck60xD4F6w==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@redhat.com, irogers@google.com, 
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
References: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf trace: guard free(new_filter) to avoid
 double-free on OOM
Message-Id: <179514684588.638421.397474996410998399.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:05 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 12 Nov 2026 11:18:09 +0800, Gu Bin wrote:
> On the asprintf() failure path in trace__expand_filter(), free(new_filter)
> is called unconditionally. On the first iteration new_filter aliases
> evsel->filter, so this frees the evsel's own filter string; when the
> error propagates and the evsel is later deleted, evsel->filter is freed
> a second time.
> 
> The success path, right below, guards the free with
> "if (new_filter != evsel->filter)". Do the same on the error path.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


