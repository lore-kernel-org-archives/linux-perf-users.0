From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf script: Add option to display guest samples in host
Date: Wed, 18 Oct 2017 08:37:49 -0600
Message-ID: <a1e7fa6d-a427-9e0f-baad-4853d63078cb@gmail.com>
References: <1508310594-51519-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508310594-51519-1-git-send-email-zhangmengting@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mengting Zhang <zhangmengting@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, dsa@cumulusnetworks.com, wangnan0@huawei.com, huawei.libin@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On 10/18/17 1:09 AM, Mengting Zhang wrote:
> @@ -2771,6 +2772,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Show context switch events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>  		    "Show namespace events (if recorded)"),
> +	OPT_BOOLEAN('\0', "show-guest-samples", &script.show_guest_samples,
> +		    "Show guest samples (if recorded)"),
>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_INTEGER(0, "max-blocks", &max_blocks,
>  		    "Maximum number of code blocks to dump with brstackinsn"),

At this point we need a 'show-all' option.
