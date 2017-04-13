From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v5] Allow user probes on versioned symbols.
Date: Thu, 13 Apr 2017 10:40:50 -0500
Message-ID: <58e0c059-5f7f-b763-4e97-c0f785dfdb69@us.ibm.com>
References: <967814e0-0d5a-4970-38d8-04d7dae9d5b1@us.ibm.com>
 <20170413112020.8c98e0a082ad821a43d968c3@kernel.org>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413112020.8c98e0a082ad821a43d968c3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 04/12/2017 09:20 PM, Masami Hiramatsu wrote:
> On Wed, 12 Apr 2017 09:41:51 -0500
> Paul Clarke <pc@us.ibm.com> wrote:
>>   static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>> -					    const char *name)
>> +					    const char *name,
>> +					    unsigned int includes)
>
> Here, you might miss replacing this 'unsigned int' with enum.
> (actually, enum is equal to int, not unsigned int)

(Ugh.) My bad. Will fix.

>> +enum symbols_tag_includes {
>> +	SYMBOLS_TAG__INCLUDE_NONE,
>> +	SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY
>> +};
>
> BTW, would we need such 's' for plural and third person singular for type name?
> And also, you should use enum type name for prefix so that other developers
> easily find the definition of enumeration, e.g.
>
> enum symbol_tag_include {
> 	SYMBOL_TAG_INCLUDE__NONE = 0,
> 	SYMBOL_TAG_INCLUDE__DEFAULT_ONLY
> };

I was thinking the top-level namespace would be "symbols", because we are not necessarily working with a single symbol.  Secondary namespace would be "tag", since this enum is very specific to tags.  Then, the actions are whether to "include none (of tagged symbols)" or "include only symbols tagged as default".

I'm fine with your suggestion, though, and will submit a new patch incorporating that soon.

Regards,
PC
