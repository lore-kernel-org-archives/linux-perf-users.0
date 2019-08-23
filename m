From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Date: Fri, 23 Aug 2019 09:00:10 +0300
Message-ID: <76459555-eab2-b55d-e5cc-1db3e956ec7f@linux.intel.com>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Linton <Jeremy.Linton@arm.com>
List-Id: linux-perf-users.vger.kernel.org


On 22.08.2019 16:55, James Clark wrote:
> Running 'perf test' with zstd compression linked will hang at the test
> 'Zstd perf.data compression/decompression' because /dev/random blocks
> reads until there is enough entropy. This means that the test will
> appear to never complete unless the mouse is continually moved while
> running it.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> index 899604d1..63a91ec 100755
> --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -13,7 +13,7 @@ skip_if_no_z_record() {
>  collect_z_record() {
>  	echo "Collecting compressed record file:"
>  	$perf_tool record -o $trace_file -g -z -F 5000 -- \
> -		dd count=500 if=/dev/random of=/dev/null
> +		dd count=500 if=/dev/urandom of=/dev/null

Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>

~Alexey

>  }
>  
>  check_compressed_stats() {
> 
