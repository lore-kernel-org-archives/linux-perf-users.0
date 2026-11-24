Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553981;
	b=gzxC+a54IQj5zKYE0LPrOduq+4HQj2H4zyNc4TdyaCIfYQD+08sfnj+DxuS+pA9o0oUt
	 8BJEOjZ8+YNFnctgvxgiK/o0RaKu70A30rBR8B9EgTpSyrVmixTPJYGk7bJf3fnkKnOt+
	 St9o5vY8l8/ZXemaGKcMWX8K+YGxXwYRwCCb9mwzike8gF5Xt3ulSYLR9p6zZfwvcqqEP
	 aax6fWQJqOu3nifa4K62ZBCNir70iupzLI7T1kfdWmVU4TwM6Mn3iBy625I+o4Ukr+K3O
	 PvheY+9PSc/tSizFZeN5J1NSWy+NGsQXMYhhIDojihVYbs2ubuM+s/h+znwWu3x+Kcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553981;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ej6SVnaMSnLxpc1LM8rFwgkJ65uicl8eNms0oJB5l7g=;
	b=ykLPaaxxusjV4HwTUGPvOFw8caMgOMB0APkSP2YDo8yn3Q4EMuxiITn5t1ae6xAJhIwB
	 sY0VRriHk2+E6CTOfiwLfvuvXBQOkvchF/yvEbDpbzpqipaVHAN0sga4jADJtZGzRbDwM
	 HlTg5OGqllzz8o4Zj6gPMAGIot3zMVP2jT65b78hWqhlATEBGa1d41VWlAv3BD29FKUhb
	 HEtogZlYwieef6zMgY77q/iRegFYw04UUFR8TYqSc9HSDLfrv9qu5YP6+5emxULKhX4mP
	 7QXwN0l9HhsyoNfwQ8m2r2TmQ8X74/YsFz/50yoSk9TC34ns2JmJis8EzFR/HoisbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rj81xLP2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B510606A32D;
	Tue, 24 Nov 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rj81xLP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F451F000CF;
	Tue, 24 Nov 2026 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553980;
	bh=Ej6SVnaMSnLxpc1LM8rFwgkJ65uicl8eNms0oJB5l7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rj81xLP2ROnQ0TJLn1NPuW6xoQNRMvXCj6VH9qAeaV9AyYYHc+CNCQp9BM6o1TBIa
	 QmhfUz/vsAndkwaIe9GWUY4c6rMfHyjcScZDFGBo1DsAyJQvtnue/WC6rYMtOp3cMc
	 lcH/pRbabmqv/gNG/G4qtfqRyuU3bDxcDaI0Vi7sJSVjM8oR//tnGkyW1ouvoNquls
	 i4VVNHCODWFS3POFqk0UUJJ9m/k4e9qljX6uddFwQZabgsBtI7yy4PfwiYPxh88+7X
	 aGLW3cFhYBQb2vZP9920DGpD2axHCe6+k4njQYaUeqx1GfE+tPrxAC2nqAigCZ4glg
	 RJ5lqjyniWKaw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
References: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf trace: free filter_pids entries in trace__exit()
Message-Id: <179555397915.1562760.796261737773441557.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:59:39 -0800
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

On Tue, 17 Nov 2026 17:56:00 +0800, Gu Bin wrote:
> trace__set_filter_pids_from_option() allocates trace->filter_pids.entries
> with calloc() when the --filter-pids option is parsed, but trace__exit()
> never frees it.  Free it there along with the other entries array of the
> trace struct, ev_qualifier_ids.

Applied to perf-tools-next, thanks!

Best regards
Namhyung


