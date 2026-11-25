Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569551;
	b=N90uuxBzRTmbVl8kP93D17dhBn0zfV2d1F0MAQMVwccnyZHhcm3kUh/Rv+/lDvO1THZ7
	 3sw9FVDFKPLXj9vg06jaBdCfJBk28MmGO8DsGXiyhQHjL4d0Y6Gt2OcwEQNhH6YIaMQdR
	 fqWr8TkUxDCbnEec4iy4cZMs4kCLxe1LeGsq41K/V1v+xYb/C5g5Ka6NgwI1suDoMna7n
	 hwBit4ZGFIGNoEoQOwui3Jh3U3B7tgnv1U4nLSFeC4kuxtDDqieXkcWVnBibN983dQrqm
	 dmGvwZkdPJvFWgDyayKkzNt6gumnGnAsr26O+8AP7OlHFoxADzb9Cuj1LeEjdBQS/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GmFQGGFUMrza2jufqoeXh+f4toB/Sj4rIXt4rxO0pfE=;
	b=MgzGdPzueq56cJ0zicd3ThL/KqcHzFXk3I3biCLHflEXmDJ0bFlG8DLc/0Ms8dB4yfo6
	 tABNpltc9/05BuDB1Q8Cu4DyAew6pOxW61V+QTmTmSTB5pEJsoajQDgxMc765ieQzXNvr
	 UZS9oYQ282TdRFhW5iJp4Q0D7tnAeN7/fvOpmCoP9E78kEbMpRA95UE7B/ytPGFHdwjEw
	 lN2R+ecpF+n2nkBMT9B7AVcY57xLyKeen5W1yNrFeFXj94xKXiThzXSPvoA3MM2Wp1ecl
	 WB6ucO4WCze6t4rAEXK3v1occXcjwb6KoitwurAxNx/cg950FZjzRsw6RDI+WKFcP4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrgr8hxk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DA606A31E;
	Wed, 25 Nov 2026 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrgr8hxk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB2F1F000C6;
	Wed, 25 Nov 2026 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569551;
	bh=GmFQGGFUMrza2jufqoeXh+f4toB/Sj4rIXt4rxO0pfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xrgr8hxkuORCU9ZmCFPACM7t5At30yfwrvtI9VnU9SxmCmMtmtViln3Cz9ltKgvRP
	 qLztEXmPc8C/68Zu6EgPExKsACPrqjJPLiXxnKuKHqExcqawO40Rmg4HiKVPblE8+s
	 P6/l2U9Kaq5B+3gEM6w9etdtFsPB0sQRUV25C1Q6wOswk6TUVH3a65fBh1wFtAFUwB
	 JLtgBaGbyLkK2Ol8f0O8GPCx3FikAwRtRzcEoKmd0tBliZofcKrqlPGJN7S7P1SH2s
	 pGaVJJQHVS/qd75W6Ughm47W/LaUMYP/4FGke5G/OyLq3Ubd8UCpq1Ovi0uZXX9tM8
	 Kps9+JOA7vFhw==
Message-ID: <sashiko-outbox-232323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/19] perf/core: Implement BUILD_ID_OFFSET and
 CALLCHAIN_BUILD_ID_OFFSET sample types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261125005108.1020003-6-irogers@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:19:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] perf/core: u16 header_size overflow in perf_prepare_sample()
  with AUX
- [Medium] perf/core: unprotected per-CPU entry in
  perf_output_sample_build_id()
- [Low] perf/core: wasted kernel IP lookup and uninit read in
  perf_prepare_sample()
--

commit 12fd54f1045a93a0b62bd4e4ddb1fe0c0c1107f8
Author: Ian Rogers <irogers@google.com>

perf/core: Implement BUILD_ID_OFFSET and CALLCHAIN_BUILD_ID_OFFSET sample t=
ypes

This commit implements synchronous PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload generation using
stack_map_get_build_id_offset() and per-CPU callchain build ID scratch
buffers.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d67bb825c504c..2a6ab82d617ef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -8394,6 +8400,78 @@ static void perf_output_read(struct perf_output_ha=
ndle *handle,
>  		perf_output_read_one(handle, event, enabled, running);
>  }
> =20
[ ... ]
> +static void perf_output_sample_build_id(struct perf_output_handle *handl=
e,
> +					struct perf_event_header *header,
> +					struct perf_sample_data *data,
> +					struct perf_event *event)
> +{
> +	u64 sample_type =3D data->type;
> +	bool sample_bid =3D sample_type & PERF_SAMPLE_BUILD_ID_OFFSET;
> +	bool callchain_bid =3D sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFF=
SET;
> +	bool crosstask =3D event->ctx->task && event->ctx->task !=3D current;
> +	bool has_user_ctx =3D is_user_task(current) && current->mm && !crosstas=
k;
> +	bool is_user =3D (header->misc & PERF_RECORD_MISC_CPUMODE_MASK) =3D=3D
> +		       PERF_RECORD_MISC_USER;
> +
> +	if (sample_bid) {
> +		if (is_user && has_user_ctx) {
> +			if (callchain_bid && data->callchain_build_id &&
> +			    data->callchain_build_id->has_ip_bid) {
> +				perf_output_put(handle,
> +						data->callchain_build_id->ip_bid);
> +			} else {
> +				struct bpf_stack_build_id bpf_bid =3D {
> +					.ip =3D data->ip,
> +				};
> +
> +				stack_map_get_build_id_offset(&bpf_bid, 1, true,
> +							      false);
> +				perf_bpf_to_sample_bid_offset(&bpf_bid);
> +				perf_output_put(handle, bpf_bid);
> +			}
> +		} else {
> +			struct perf_sample_build_id_offset bid_offset =3D {
> +				.offset =3D data->ip,
> +			};
> +
> +			perf_output_put(handle, bid_offset);
> +		}
> +	}
> +
> +	if (callchain_bid) {
> +		struct perf_callchain_build_id_entry *entry =3D
> +			data->callchain_build_id;
> +
> +		__output_copy(handle, &entry->nr_build_ids,
> +			      sizeof(u64) + entry->build_ids_len);
> +		if (entry->nr_offsets) {
> +			__output_copy(handle, entry->offsets,
> +				      entry->nr_offsets * sizeof(u64));
> +		}
> +	}
> +}

[Severity: Medium]
Can a nested perf event overwrite data->callchain_build_id during
stack_map_get_build_id_offset() here?

When callchain->nr > 0 but nr_bpf_bids =3D=3D 0 (for example, when
exclude_callchain_user is set or no user frames follow PERF_CONTEXT_USER),
perf_callchain_build_id() skips resolving ip, leaves entry->has_ip_bid
false, and releases callchain_recursion[rctx] before returning the per-CPU
entry:

kernel/events/callchain.c:perf_callchain_build_id() {
	...
		if (nr_bpf_bids > 0) {
			if (resolve_ip) {
				bpf_bids[0].ip =3D ip;
				ip_slot =3D 1;
			}
	...
	perf_callchain_encode_build_ids(entry, callchain->ip, nr, user_start,
					bpf_bids + ip_slot, nr_bpf_bids,
					max_size);
	put_callchain_entry(rctx);

	return entry;
}

If the sampled IP was in user mode, perf_output_sample_build_id() then
falls back to calling stack_map_get_build_id_offset() after
perf_output_begin() has already reserved header->size bytes and while
callchain_recursion[rctx] is no longer held:

__perf_event_output()
  perf_prepare_sample()
    perf_callchain_build_id()
      get_callchain_build_id_entry()
      /* nr_bpf_bids =3D=3D 0: entry->has_ip_bid remains false */
      put_callchain_entry(rctx)
  perf_output_begin()               /* reserves header->size bytes */
  perf_output_sample()
    perf_output_sample_build_id()
      stack_map_get_build_id_offset()
        mmap_read_trylock()
          <tracepoint / kprobe perf event at same context level>
            perf_prepare_sample()
              perf_callchain_build_id()
                /* reuses same per-CPU entry and increases
                 * entry->build_ids_len / entry->nr_offsets
                 */
      __output_copy(..., entry->build_ids_len)  <-- writes past reserved si=
ze

Resolving ip in perf_callchain_build_id() whenever resolve_ip &&
has_user_ctx (even if nr_bpf_bids =3D=3D 0, or when !callchain->nr) would a=
void
calling stack_map_get_build_id_offset() during output while the per-CPU
entry is unprotected.

[ ... ]

> @@ -8963,6 +9052,24 @@ void perf_prepare_sample(struct perf_sample_data *=
data,
>  		data->sample_flags |=3D PERF_SAMPLE_CODE_PAGE_SIZE;
>  	}
> =20
> +	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
> +		u32 header_size =3D perf_sample_data_size(data, event);
> +		u32 max_size =3D 0;
> +		struct perf_callchain_build_id_entry *entry;
> +
> +		if (header_size < U16_MAX)
> +			max_size =3D round_down(U16_MAX - header_size, sizeof(u64));
> +
> +		entry =3D perf_callchain_build_id(event, data->callchain,
> +						data->ip,
> +						!!(sample_type & PERF_SAMPLE_BUILD_ID_OFFSET),
> +						max_size);

[Severity: Low]
Does this pass resolve_ip =3D true for kernel-mode samples and read
data->ip when PERF_SAMPLE_IP was not prepared?

When a user task is sampled in kernel mode with both
PERF_SAMPLE_BUILD_ID_OFFSET and PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
enabled, perf_callchain_build_id() looks up the kernel data->ip in
current->mm via stack_map_get_build_id_offset(), even though
perf_output_sample_build_id() checks is_user and discards entry->ip_bid.
Also, when PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is used without
PERF_SAMPLE_IP, PERF_SAMPLE_CODE_PAGE_SIZE, or PERF_SAMPLE_BUILD_ID_OFFSET,
data->ip is uninitialized on the stack when passed by value here.  Finally,
perf_callchain_build_id() clamps nr_bpf_bids to max_size / sizeof(u64)
without subtracting user_start, so it can resolve up to user_start trailing
user frames that cannot fit in max_size.

> +		data->callchain_build_id =3D entry;
> +		data->dyn_size +=3D entry->build_ids_len +
> +				  entry->nr_offsets * sizeof(u64);
> +		data->sample_flags |=3D PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
> +	}
> +
>  	if (filtered_sample_type & PERF_SAMPLE_AUX) {
>  		u64 size;
>  		u16 header_size =3D perf_sample_data_size(data, event);

[Severity: High]
Can header_size in the PERF_SAMPLE_AUX block wrap u16 to 0 when
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is also enabled?

max_size above allows the sample up to the end of
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET to reach round_down(U16_MAX, 8)
(65528 bytes) without reserving the 8-byte aux_size field that
PERF_SAMPLE_AUX unconditionally emits.  When perf_sample_data_size(data,
event) reaches 65528, the PERF_SAMPLE_AUX block's

	u16 header_size =3D perf_sample_data_size(data, event);

	header_size +=3D sizeof(u64); /* size */

wraps header_size to 0.  U16_MAX - header_size then becomes 65535,
data->dyn_size exceeds 64 KiB, and perf_prepare_header() truncates u16
header->size, causing perf_output_sample() to write 64 KiB more into the
perf ring buffer than perf_output_begin() reserved.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125005108.1020=
003-1-irogers@google.com?part=3D5
