From: =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Date: Mon, 27 Aug 2018 11:06:21 +0200
Message-ID: <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180823141219.GA4766@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8F122A30081B3AC6B8DE1ED1"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823141219.GA4766@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------8F122A30081B3AC6B8DE1ED1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/23/2018 04:12 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
>> The patch changes interpretation of:
>> callq  *0x8(%rbx)
>>
>> from:
>>   0.26 │     → callq  *8
>> to:
>>   0.26 │     → callq  *0x8(%rbx)
>>
>> in this can an address is followed by a register, thus
>> one can't parse only address.
> 
> Please mention one or two functions where such sequence appears, so that
> others can reproduce your before/after more quickly,

Sure, there's self-contained example on can compile (-O2) and test.
It's following call in test function:

test:
.LFB1:
        .cfi_startproc
        movq    %rdi, %rax
        subq    $8, %rsp
        .cfi_def_cfa_offset 16
        movq    %rsi, %rdi
        movq    %rdx, %rsi
        call    *8(%rax) <---- here
        cmpl    $1, %eax
        adcl    $-1, %eax
        addq    $8, %rsp
        .cfi_def_cfa_offset 8
        ret
        .cfi_endproc

Martin

> 
> - Arnaldo
>  
>> Signed-off-by: Martin Liška <mliska@suse.cz>
>> ---
>>  tools/perf/util/annotate.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>>
> 
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index e4268b948e0e..e32ead4744bd 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>>  
>>  indirect_call:
>>  	tok = strchr(endptr, '*');
>> -	if (tok != NULL)
>> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
>> +	if (tok != NULL) {
>> +		endptr++;
>> +
>> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
>> +		 * Do not parse such instruction.  */
>> +		if (strstr(endptr, "(%r") == NULL)
>> +			ops->target.addr = strtoull(endptr, NULL, 16);
>> +	}
>>  	goto find_target;
>>  }
>>  
>>
> 

--------------8F122A30081B3AC6B8DE1ED1
Content-Type: text/x-csrc;
 name="perf-callq.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="perf-callq.c"

typedef int (*htab_eq) (const void *, const void *);

static int eq (const void *a, const void *b)
{
  return a - b;
}

struct htab
{
  /* Current size (in entries) of the hash table */
  int size;

  /* Pointer to comparison function.  */
  htab_eq eq_f;

  /* Table itself.  */
  void **entries;

  /* Current number of elements including also deleted elements */
  int n_elements;

  /* Current number of deleted elements in the table */
  int n_deleted;

  /* The following member is used for debugging. Its value is number
     of all calls of `htab_find_slot' for the hash table. */
  unsigned int searches;

  /* The following member is used for debugging.  Its value is number
     of collisions fixed for time of work with the hash table. */
  unsigned int collisions;

  unsigned int max_size;

  /* This is non-zero if we are allowed to return NULL for function calls
     that allocate memory.  */
  int return_allocation_failure;
};

int
__attribute__ ((noinline))
test(struct htab *t, int *a, int *b)
{
  int r = t->eq_f (a, b);
  if (r)
    return r - 1;

  return 0;
}

struct htab mytable;
int r;

int main(int argc, char **argv)
{
  mytable.eq_f = &eq;
  for (unsigned i = 0; i < 100000000; i++)
    r += test (&mytable, &argc, &argc);
  
  return 0;
}

--------------8F122A30081B3AC6B8DE1ED1--
