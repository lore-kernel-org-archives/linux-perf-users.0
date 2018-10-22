From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
Date: Mon, 22 Oct 2018 10:13:48 -0700
Message-ID: <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: sebhtml@videotron.qc.ca
Cc: Steven Rostedt <rostedt@goodmis.org>, acme@redhat.com, tz.stoyanov@gmail.com, Namhyung Kim <namhyung@kernel.org>, zwisler@kernel.org, arangradient@gmail.com, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

[ added Andrew ]

Patch here: https://lore.kernel.org/patchwork/patch/1002234/

On Sun, Oct 21, 2018 at 8:00 AM Sebastien Boisvert
<sebhtml@videotron.qc.ca> wrote:
>
> Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
> warning:
>       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
>
> It is printed in process_op (tools/lib/traceevent/event-parse.c) because '~'
> is parsed as a binary operator.
>
> perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
> /sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .
>
> The format contains:
>
> ~(((u64) ~(~(((1UL) << 12)-1)))
>          ^
>          \ interpreted as a binary operator by process_op().
>
> This part is generated in the declaration of the event class
> dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :
>
>                 __print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
>                         PFN_FLAGS_TRACE),
>
> This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK to
> make sure that '~' is parsed as a unary operator by perf.
>
> The part of the format that was problematic is now:
>
> ~(((u64) (~(~(((1UL) << 12)-1))))
>
> Now, all the '~' are parsed as unary operators.
>
> Cc: Dan Williams <dan.j.williams@intel.com>


Acked-by: Dan Williams <dan.j.williams@intel.com>


> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Elenie Godzaridis <arangradient@gmail.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sebastien Boisvert <sebhtml@videotron.qc.ca>
> ---
>  include/linux/pfn_t.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 21713dc14ce2..673546ba7342 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -10,7 +10,7 @@
>   * PFN_DEV - pfn is not covered by system memmap by default
>   * PFN_MAP - pfn has a dynamic page mapping established by a device driver
>   */
> -#define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
> +#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
>  #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
>  #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
>  #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
> --
> 2.17.1
>
