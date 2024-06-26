Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A64ED9;
	Wed, 26 Jun 2024 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374450; cv=none; b=fb1qZvKhfd0+APeJOlVBIh7LlO8QOY0t4AjIMoy77y/ERwMkTrJxx2VcsIXzyEErCPFQnAN8RkqOphOQmPWILPIKa7OYvegUXU02XUopLl+B1fLYx6txOKe8719SQhDX65sIuDrKyJvqgwwrQtND47IR1P9OQBQ0iEun9szbpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374450; c=relaxed/simple;
	bh=ng+/tl0qGvTHsx47qQ+djVxUwDjC+tolYkRiWvOWNdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ez6MPSOhW8PAfHbtgyYRwIF/ObjOsH4pi4iC1ZIb9BPtF1xgepbNtJKkl97GCNn8sp0o0LO6JSn43/fRWWEWqJ62ppSZwnRVJL6Ox5HBWAbikwiXoL9zakuQ7MuzHezVdK5cbsKD+PrDbOaw6jqwqbqdrwBJU6uKF5t1bmrMogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZd6Z7BO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZd6Z7BO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DECFC2BD10;
	Wed, 26 Jun 2024 04:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374449;
	bh=ng+/tl0qGvTHsx47qQ+djVxUwDjC+tolYkRiWvOWNdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZd6Z7BOv4R2Y3Nsnr+gl9k+Jhke8Cu9Spy79QlR6cqBin8ZYd3pR2Xzm2TY4HfK6
	 pXWl8o7fx+jcQcOXtDfMTb28g3FsrD2Mg7Ee3gxA9KwQNRxOwq66Wf/PqEvWuLfvzs
	 ZeXLU8aNhRVAkl8dhfSn72a0zX+hQCWuAVxFWc/NJH832MSbhXStQ+GbnUkz9Z3mZq
	 yzJz8a9NbjqttPWGZE1nN+5Tur8ot0+U2pIjxQFyKXQdsBQ9K4L5cqi8iUMPEqnL1A
	 HgVLRhgOUH3kOz9V/V0VzbvhAbzLk8GIk3bR4Zv5KZva3U5Pj1mI7IP3diqqUz33Oq
	 GVwl6YoS3KTjw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	yskelg@gmail.com
Cc: kan.liang@linux.intel.com,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] util: constant -1 with expression of type char
Date: Tue, 25 Jun 2024 21:00:46 -0700
Message-ID: <171937440506.2859857.1630570661354728830.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240619203428.6330-2-yskelg@gmail.com>
References: <20240619203428.6330-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 05:34:29 +0900, yskelg@gmail.com wrote:

> This patch resolve following warning.
> 
> tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
> -1 with expression of type 'char' is always false
>  -Werror,-Wtautological-constant-out-of-range-compare
>  1620 |                 if (c == -1)
>       |                     ~ ^  ~~
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
