Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3C1EB3C
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA5A121
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 06:00:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B23FEDA7;
	Wed, 15 Nov 2023 06:01:09 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494F53F641;
	Wed, 15 Nov 2023 06:00:22 -0800 (PST)
Message-ID: <a7f2715f-a47a-c619-329f-668f8c7b6b12@arm.com>
Date: Wed, 15 Nov 2023 14:00:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf/tests:coresight:remove unused variables
Content-Language: en-US
To: zhujun2 <zhujun2@cmss.chinamobile.com>, suzuki.poulose@arm.com
Cc: mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20231115064255.11057-1-zhujun2@cmss.chinamobile.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231115064255.11057-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/11/2023 06:42, zhujun2 wrote:
> These variables are never referenced in the code, just remove them.
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c   | 1 -
>  tools/perf/tests/shell/coresight/thread_loop/thread_loop.c       | 1 -
>  .../shell/coresight/unroll_loop_thread/unroll_loop_thread.c      | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> index a7e169d1bf64..5f886cd09e6b 100644
> --- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> @@ -42,7 +42,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>  int main(int argc, char **argv)
>  {
>  	unsigned long i, len, size, thr;
> -	pthread_t threads[256];
>  	struct args args[256];
>  	long long v;
>  
> diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
> index c0158fac7d0b..e05a559253ca 100644
> --- a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
> +++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
> @@ -57,7 +57,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>  int main(int argc, char **argv)
>  {
>  	unsigned int i, len, thr;
> -	pthread_t threads[256];
>  	struct args args[256];
>  
>  	if (argc < 3) {
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> index 8f6d384208ed..0fc7bf1a25af 100644
> --- a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> @@ -51,7 +51,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>  int main(int argc, char **argv)
>  {
>  	unsigned int i, thr;
> -	pthread_t threads[256];
>  	struct args args[256];
>  
>  	if (argc < 2) {

Reviewed-by: James Clark <james.clark@arm.com>
