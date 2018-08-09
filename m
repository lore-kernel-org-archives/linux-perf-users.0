From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Date: Thu, 9 Aug 2018 06:35:58 +0200
Message-ID: <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org> <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org> <20180808161451.GD9543@kernel.org>
 <20180808164214.GE9543@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808164214.GE9543@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 08/08/2018 06:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 08, 2018 at 01:14:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Aug 08, 2018 at 01:08:43PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> No need for __packed.
>>  
>>> I'm removing that to avoid having this failling in compilers that have
>>> such a warning, since we default to Werror.
>>  
>>> Holler if there is something I'missing :-)
>>
>> In file included from util/cpumap.h:10,
>>                  from util/s390-cpumsf.c:150:
>> util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
>> util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
>>  #define pr_fmt(fmt) fmt
>>                      ^~~
>> util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
>>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>>    ^~~~~~
>> util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
>> util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>>    pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
> 
> So for those I applied this, seems to pass the ones that were failing,
> restarting tests...
> 
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 2bcb160a08f0..d2c78ffd9fee 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -187,7 +187,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
>  		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Basic   Def:%04x Inst:%#04x"
> +	color_fprintf(stdout, color, "    [%#08zx] Basic   Def:%04x Inst:%#04x"
>  		      " %c%c%c%c AS:%d ASN:%#04x IA:%#018llx\n"
>  		      "\t\tCL:%d HPP:%#018llx GPP:%#018llx\n",
>  		      pos, basic->def, basic->U,
> @@ -205,10 +205,10 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
>  				  struct hws_diag_entry *diag)
>  {
>  	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
> -		pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
> +		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Diag    Def:%04x %c\n",
> +	color_fprintf(stdout, color, "    [%#08zx] Diag    Def:%04x %c\n",
>  		      pos, diag->def, diag->I ? 'I' : ' ');
>  	return true;
>  }
> @@ -230,10 +230,10 @@ static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
>  				     struct hws_trailer_entry *te)
>  {
>  	if (te->bsdes != sizeof(struct hws_basic_entry)) {
> -		pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
> +		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
>  		return false;
>  	}
> -	color_fprintf(stdout, color, "    [%#08x] Trailer %c%c%c bsdes:%d"
> +	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
>  		      " dsdes:%d Overflow:%lld Time:%#llx\n"
>  		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
>  		      pos,
> @@ -418,7 +418,7 @@ static bool s390_cpumsf_make_event(size_t pos,
>  	event.sample.header.misc = sample.cpumode;
>  	event.sample.header.size = sizeof(struct perf_event_header);
>  
> -	pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
> +	pr_debug4("%s pos:%#zx ip:%#" PRIx64 " P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
>  		 __func__, pos, sample.ip, basic->P, basic->CL, sample.pid,
>  		 sample.tid, sample.cpumode, sample.cpu);
>  	if (perf_session__deliver_synth_event(sfq->sf->session, &event,
> @@ -498,7 +498,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
>  	 */
>  	aux_ts = get_trailer_time(buf);
>  	if (!aux_ts) {
> -		pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
> +		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
>  		       sfq->buffer->data_offset);
>  		aux_ts = ~0ULL;
>  		goto out;
> @@ -607,7 +607,7 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
>  		buffer->use_size = buffer->size;
>  		buffer->use_data = buffer->data;
>  	}
> -	pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
> +	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
>  		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
>  		  buffer->size, buffer->use_size);
>  	err = s390_cpumsf_samples(sfq, ts);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I just updated the perf/core branch, compiled it and all works fine.

Thanks for fixing these errors.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
