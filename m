From: sebhtml <sebhtml@videotron.qc.ca>
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
Date: Wed, 24 Oct 2018 19:52:40 -0400
Message-ID: <d48b2b1b-201a-d350-6bda-943a66f1abfb@videotron.qc.ca>
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
 <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
 <FRrzgp7InaOtKFRs0geay1@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FRrzgp7InaOtKFRs0geay1@videotron.ca>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, acme@redhat.com, tz.stoyanov@gmail.com, Namhyung Kim <namhyung@kernel.org>, zwisler@kernel.org, arangradient@gmail.com, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 2018-10-24 6:43 p.m., Andrew Morton wrote:
> 
> I grabbed it, and added cc:stable.
> 
> But aren't we fixing this in the wrong place?  That's a valid
> expression and if this isn't addressed in perf then we may hit a
> similar issue elsewhere...
> 

Right.

Based on:
     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 01aa9d518eae8a4d75cd3049defc6ed0b6d0a658

In perf, the warning
       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
comes from tools/lib/traceevent/event-parse.c at line 2045:
                 do_warning_event(event, "unknown op '%s'", token);

This is in this function:

static enum tep_event_type
process_op(struct tep_event_format *event, struct tep_print_arg *arg, char **tok);

The code path to reach the good '~' case needs:
         if (arg->type == TEP_PRINT_OP && !arg->op.left) {

I assume that here arg->op.left is not NULL because of (u64) on the left.

~(((u64) ~(~(((1UL) << 12)-1)))
          ^

However, I fail to see where '~' is parsed as a binary operator though.

Any pointer would be welcome.
