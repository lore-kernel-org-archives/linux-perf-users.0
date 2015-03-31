From: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Subject: Fwd: perf smapling
Date: Tue, 31 Mar 2015 17:15:04 +0300
Message-ID: <CAL2Y34CxT=YRGx6G0kcCWK0AVnaPdb4ybL+u-BiUE7gYg1jYGg@mail.gmail.com>
References: <loom.20150329T075320-204@post.gmane.org>
	<CAL2Y34Bi+VLSvGucN8J=4RXKh785Lg9BYAa4LUU_yCMR7COTgQ@mail.gmail.com>
	<20150331111813.GA1152@ubuntu>
	<CAL2Y34A=Fk03_LSTM_SHwVaE4NaKSD=zZt0vWtzn3Rm9dQtDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36353 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbbCaOPE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 Mar 2015 10:15:04 -0400
Received: by iedm5 with SMTP id m5so16732682ied.3
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2015 07:15:04 -0700 (PDT)
In-Reply-To: <CAL2Y34A=Fk03_LSTM_SHwVaE4NaKSD=zZt0vWtzn3Rm9dQtDLQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>, linux-perf-users@vger.kernel.org

I wanted to ensure the user always see contiguous array of data from
the ring buffer.

The last piece of data, say "abcde" could wrap around in the ring
buffer and appear like:

[de...                 ...abc]

I wanted the user to see a contigious array of the form [abcde].

So in the case I'm having input that wrap around, I'll simply copy it
to the first buffer

[wrap_buffer][de..                 ...abc]
would become
[               abc][de...               ...abc]

And then I'll the user pointer to the leftmost "a", and he'll see
"abcde" without knowing he's handling a ring buffer.

Let me know if I was clear enough.

On Tue, Mar 31, 2015 at 2:18 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>
> Hi Elazar
>
> Can you help me understand why you have used
> mmap_pages->wrap_base.? And, instead of allocating
> (2^n)+1 pages you allocate (2^n)+2 pages, why so.?
> wrap_base points to (2^n)+2 pages and base points to
> (2^n)+1 pages, what is use of wrap_base.? I tried reading
> perf source too, there it seems they use (2^n)+1 pages only.
>
>
> Thanks
> Regards
